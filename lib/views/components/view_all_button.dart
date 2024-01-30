import 'package:flutter/material.dart';

class ViewAllButton extends StatelessWidget {
  final VoidCallback? onViewAll;
  final IconData? icon;
  final String? text;

  const ViewAllButton({
    super.key,
    required this.onViewAll,
    this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewAll,
      child: Row(
        children: [
          Text(
            text ?? "",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12.0,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(width: 5),
          Icon(
            icon ?? Icons.arrow_forward_ios,
            size: icon == null ? 25 : 15,
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
    );
  }
}
