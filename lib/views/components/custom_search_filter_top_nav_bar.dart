import 'package:flutter/material.dart';

class CustomSearchFilterTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onFilterButtonPressed;

  const CustomSearchFilterTopNavBar({
    super.key,
    required this.searchController,
    this.onBackButtonPressed,
    this.onFilterButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackButtonPressed ?? () {
          // TODO: Define back button functionality
        },
      ),
      title: Container(
        height: 40,
        margin: const EdgeInsets.only(right: 8, left: 8),
        decoration: BoxDecoration(
          color: const Color(0xEDFAFAFA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(Icons.search, color: Color(0x993C3C43)),
            hintStyle: TextStyle(
              color: Color(0x993C3C43),
              fontSize: 17,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.41,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list_rounded),
          onPressed: onFilterButtonPressed ?? () {
            // TODO: Define filter button functionality
          },
        ),
      ],
      titleSpacing: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
