import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...buildCardContent(), // Call to the overridable method
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
            ),
          ],
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
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
            'assets/images/default_image.png',
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
