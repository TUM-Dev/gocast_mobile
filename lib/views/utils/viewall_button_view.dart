import 'package:flutter/material.dart';

class ViewAllButton extends StatelessWidget {
  final VoidCallback? onViewAll;

  const ViewAllButton({
    super.key,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onViewAll,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black, side: const BorderSide(color: Colors.black), // Text and icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), // Padding inside the button
      ),
      child:const  Row(
        mainAxisSize: MainAxisSize.min, // To minimize the button width
        children: [
          Text('View All'),
          Icon(Icons.arrow_forward_ios, size: 14), // Use a smaller icon size for the arrow
        ],
      ),
    );
  }
}