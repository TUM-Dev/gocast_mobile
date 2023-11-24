// CourseListScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/View/utils/custom_bottom_nav_bar.dart';

class CourseListScreen extends ConsumerWidget {
  final String title;
  final List<Widget> videoCards;

  const CourseListScreen({
    super.key,
    required this.title,
    required this.videoCards,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Implement more options functionality
            },
          ),
        ],
      ),
      body: ListView(
        children: videoCards,
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
