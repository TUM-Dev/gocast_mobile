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
    ThemeData themeData = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        color: themeData.cardTheme.color,
        shadowColor: themeData.shadowColor,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...buildCardContent(), // Call to the overridable method
            /*const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
            ),*/
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
  Widget buildHeader({
    required String title,
    required String subtitle,
    int?  length,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          if (length != null) _buildStreamLength(length!),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  String formatDuration(int durationInMinutes) {
    print("durationInMinutes $durationInMinutes");
    int hours = durationInMinutes ~/ 60;
    int minutes = durationInMinutes % 60;
    int seconds = 0;

    String formattedHours = hours < 10 ? '0$hours' : '$hours';
    String formattedMinutes = minutes < 10 ? '0$minutes' : '$minutes';
    String formattedSeconds = seconds < 10 ? '0$seconds' : '$seconds';

    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  Widget _buildStreamLength(int length) {
    if (length == null) return const SizedBox();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,  //themeData.shadowColor.withOpacity(0.15), //Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(3),
      child: Text(
        formatDuration(length),
        style: TextStyle(//themeData.textTheme.labelSmall?.copyWith(
          fontSize: 12,
          //fontWeight: FontWeight.bold,
          //height: 1,
        ) ??
            const TextStyle(),
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
