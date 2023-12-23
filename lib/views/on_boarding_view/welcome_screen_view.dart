import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/login_view/internal_login_view.dart';

/// Welcome screen view.
/// This is the first screen that the user sees when the app is opened.
/// It contains a welcome text, a login button and a continue without login button.
/// The login button calls the SSO authentication function from /base/api/auth
/// The continue without login button does nothing for now.
/// The internal account link navigates to the internal login screen.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Getting screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: isPortrait
              ? _buildPortraitLayout(context, ref, screenSize)
              : _buildLandscapeLayout(context, ref, screenSize),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(
    BuildContext context,
    WidgetRef ref,
    Size screenSize,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Spacer(),
        _buildLogo(screenSize),
        SizedBox(height: screenSize.height * 0.03),
        _buildWelcomeText(),
        const SizedBox(height: 8),
        _buildOverviewText(),
        const Spacer(),
        _buildLoginButton(context, ref),
        const SizedBox(height: 12),
        _buildContinueWithoutButton(context),
        const SizedBox(height: 12),
        _buildInternalAccountLink(context),
        SizedBox(height: screenSize.height * 0.06),
      ],
    );
  }

  Widget _buildLandscapeLayout(
    BuildContext context,
    WidgetRef ref,
    Size screenSize,
  ) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenSize.height),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildLogo(screenSize),
              const SizedBox(height: 24),
              _buildWelcomeText(),
              const SizedBox(height: 8),
              _buildOverviewText(),
              const SizedBox(height: 48),
              _buildLoginButton(context, ref),
              const SizedBox(height: 12),
              _buildContinueWithoutButton(context),
              const SizedBox(height: 12),
              _buildInternalAccountLink(context),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Size screenSize) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset(
          'assets/images/logo.png',
          width: screenSize.width * 0.5, // Responsive width
          height: screenSize.width * 0.5, // Responsive height
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      'Welcome to Gocast',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0D47A1),
      ),
    );
  }

  Widget _buildOverviewText() {
    return const Text(
      "Your Lectures on the Go",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.black54),
    );
  }

  Widget _buildLoginButton(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(userViewModelProvider);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.buttonVerticalPadding,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      child: viewModel.isLoading
          ? const SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text('TUM Login', style: TextStyle(fontSize: 18)),
      onPressed: () => handleSSOLogin(context, ref),
    );
  }

  Widget _buildContinueWithoutButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.blue[900] ?? Colors.blue),
        foregroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.buttonVerticalPadding,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      child: const Text('Continue without', style: TextStyle(fontSize: 18)),
      onPressed: () {
        //TODO: Continue without login action
        Navigator.pushNamed(context, '/publiccourses');
      },
    );
  }

  Widget _buildInternalAccountLink(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InternalLoginScreen()),
      ),
      child: const Center(
        child: Text(
          'Use an internal account',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.grey,
            decorationColor: Colors.grey,
          ),
        ),
      ),
    );
  }

  Future<void> handleSSOLogin(BuildContext context, WidgetRef ref) async {
    await ref.read(userViewModelProvider.notifier).ssoAuth(context, ref).then(
          (value) => {
            if (ref.read(userViewModelProvider).user != null)
              {Navigator.pushNamed(context, '/courses')}
            else
              {Navigator.pushNamed(context, '/welcome')},
          },
        );
  }
}
