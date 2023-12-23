import 'package:flutter/material.dart';

class ViewAllButton extends StatelessWidget {
  final VoidCallback? onViewAll;

  const ViewAllButton({
    super.key,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewAll,
      child: const Icon(
        Icons.arrow_forward_ios,
        size: 25,
        color: Colors.black,
      ),
    );
  }
}
