import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/View/utils/custom_bottom_nav_bar.dart';
import 'package:gocast_mobile/View/utils/video_card_view.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
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
        children: const <Widget>[
          VideoCard(
            imageName: 'assets/images/course1.png',
            title: 'Lineare Algebra für Informatik [MA0901]',
            date: 'July 24, 2019',
            duration: '02:00:00',
          ),
          VideoCard(
            imageName: 'assets/images/course2.png',
            title: 'Computer Science [CS202]',
            date: 'July 23, 2019',
            duration: '02:00:00',
          ),
          // Add more DownloadItem widgets as needed
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar()
    ,
    );
  }
}
