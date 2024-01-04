import 'package:flutter/material.dart';


class BigCard extends StatelessWidget {
  final String imageName;

  final VoidCallback onTap;

  const BigCard({
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
    // Default content or abstract if BigCard is abstract
    return [];
  }

  @protected
  Widget buildHeader(String courseNameAndSlug, String courseDetails) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildInfo(courseNameAndSlug, courseDetails),
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
