import 'package:flutter/material.dart';
import 'package:gocast_mobile/utils/theme.dart';

class BaseCard extends StatelessWidget {
  final String imageName;
  final VoidCallback onTap;

  const BaseCard({
    super.key,
    required this.imageName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        color: themeData.cardTheme.color,
        shadowColor: themeData.shadowColor,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: buildCardContent(),
        ),
      ),
    );
  }

  @protected
  List<Widget> buildCardContent() {
    return [];
  }

  @protected
  Widget buildHeader({
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: appTheme.cardTheme.color,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget buildInfo(String courseNameAndSlug, String courseDetails) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseNameAndSlug,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
          const SizedBox(height: 8.0),
          Text(
            courseDetails,
            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildInternetImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        imageName,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/course1.png',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.asset(
        imageName,
        fit: BoxFit.cover,
      ),
    );
  }
}
