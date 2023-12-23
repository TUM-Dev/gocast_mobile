import 'package:flutter/material.dart';
import 'package:gocast_mobile/views/components/custom_bottom_nav_bar.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar.dart';

class PinnedCoursesBaseView extends StatelessWidget {
  final Widget child;
  final VoidCallback? onBackButtonPressed;
  final TextEditingController searchController;

  const PinnedCoursesBaseView({
    super.key,
    required this.child,
    this.onBackButtonPressed,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSearchTopNavBar(
        searchController: searchController,
        title: 'Pinned Courses',
      ),
      body: child,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
