import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/course_detail_view/stream_card.dart';

import 'detail_course_List.dart';

class DetailCoursesContentView extends ConsumerWidget {
  final String title;
  final List<StreamCard> streamCards;

  const DetailCoursesContentView({
    super.key,
    required this.title,
    required this.streamCards,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DetailCourseList(
      title: title,
      streamCard: streamCards,
    );
  }
}
