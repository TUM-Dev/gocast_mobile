import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/course_detail_view/stream_card.dart';

class DetailCourseList extends ConsumerWidget {
  final String title;
  final List<StreamCard> streamCard;
  final Future<void> Function()? onRefresh;

  const DetailCourseList({
    super.key,
    required this.title,
    required this.streamCard,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
      title: title,
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
      child: streamCard.isEmpty
          ? const Center(
              child: Text(
                'No Stream',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: streamCard.length,
              itemBuilder: (BuildContext context, int index) {
                return streamCard[index];
              },
            ),
    );
  }
}
