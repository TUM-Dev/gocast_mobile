import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String imageName;
  final String title;
  final String date;
  final String duration;
  final VoidCallback onTap; // Add this line

  const VideoCard({
    super.key,
    required this.imageName,
    required this.title,
    required this.date,
    required this.duration,
    required this.onTap, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Wrap the Card with InkWell
      onTap: onTap, // Use the onTap callback
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // To reduce the height of the card
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              // Aligns the timestamp to the bottom right of the image
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    imageName,
                    fit: BoxFit
                        .cover, // This will cover the entire space of the Stack
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Padding for the duration chip inside the stack
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0,),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      // Semi-transparent black background
                      borderRadius: BorderRadius.circular(
                          4.0,), // Rounded corners for the chip
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 8.0, bottom: 12.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(date),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
