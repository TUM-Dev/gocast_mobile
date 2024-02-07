import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/views/components/base_view.dart';
import 'package:gocast_mobile/views/components/custom_search_top_nav_bar.dart';
import 'package:gocast_mobile/views/course_view/components/small_stream_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// CourseListScreen
///
/// This screen displays a list of courses.
///
/// It takes a [title] to display the title of the section and
/// dynamically generates a horizontal list of courses.
class DownloadCoursesContentView extends ConsumerWidget {
  final List<SmallStreamCard> videoCards;
  final CustomSearchTopNavBar customAppBar;

  const DownloadCoursesContentView({
    super.key,
    required this.videoCards,
    required this.customAppBar,
  });

  //TODO implement filter and search functions in download view

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;

    return BaseView(
      customAppBar: customAppBar,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                width >= 600 ? MediaQuery.of(context).size.width * 0.15 : 0,
          ),
          child: ListView.builder(
            itemCount: videoCards.isEmpty ? 1 : videoCards.length,
            itemBuilder: (BuildContext context, int index) {
              if (videoCards.isEmpty) {
                return Center(
                  child: Padding(
                    padding: AppPadding.sectionPadding,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 295.0),
                        child: Text(AppLocalizations.of(context)!
                            .no_downloaded_courses,),
                      ),
                    ),
                  ),
                );
              } else {
                return videoCards[index];
              }
            },
          ),
        ),
      ),
    );
  }
}
