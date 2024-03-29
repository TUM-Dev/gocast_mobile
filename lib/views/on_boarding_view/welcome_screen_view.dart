import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/login_view/internal_login_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

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
    final connectivityStatus = ref.watch(connectivityProvider);
    Logger().i(connectivityStatus.toString());
    return connectivityStatus.when(
      data: (result) {
        // If there's no connectivity, navigate or replace the current view.
        if (result == ConnectivityResult.none) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (ModalRoute.of(context)?.settings.name != '/downloads') {
              Navigator.of(context).pushReplacementNamed('/downloads');
            }
          });
        }
        return _buildMainLayout(context, ref);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return Center(
          child: Text(
            AppLocalizations.of(context)!.error_occurred,
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }

  Widget _buildMainLayout(BuildContext context, WidgetRef ref) {
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
        _buildWelcomeText(context),
        const SizedBox(height: 8),
        _buildOverviewText(context),
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
              _buildWelcomeText(context),
              const SizedBox(height: 8),
              _buildOverviewText(context),
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

  Widget _buildWelcomeText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.welcome_to_gocast,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0D47A1),
      ),
    );
  }

  Widget _buildOverviewText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.your_lectures_on_the_go,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, color: Colors.black54),
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
          : Text(
              AppLocalizations.of(context)!.tum_login,
              style: const TextStyle(fontSize: 18),
            ),
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
      child: Text(
        AppLocalizations.of(context)!.continue_without,
        style: const TextStyle(fontSize: 18),
      ),
      onPressed: () {
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
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.use_an_internal_account,
          style: const TextStyle(
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
