import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String path;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Adjust the width as needed
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              path, // Replace with the actual path to your course image
              fit: BoxFit.cover,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ), // Replace with the exact color
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ), // Replace with the exact color
          ),
        ],
      ),
    );
  }
}
