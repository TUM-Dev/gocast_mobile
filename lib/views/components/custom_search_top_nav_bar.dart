import 'package:flutter/material.dart';

class CustomSearchTopNavBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;
  final VoidCallback? onBackButtonPressed;

  const CustomSearchTopNavBar({
    super.key,
    this.onBackButtonPressed,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackButtonPressed ??
            () {
              // TODO: functionality will be implemented
            },
      ),
      title: Container(
        height: 40,
        margin: const EdgeInsets.only(right: 40),
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
      titleSpacing: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
