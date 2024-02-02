import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/utils/constants.dart';
import 'package:gocast_mobile/utils/tools.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';
import 'package:intl/intl.dart';

class StreamCard extends ConsumerStatefulWidget {
  final Stream stream;
  final String imageName;
  final VoidCallback onTap;

  const StreamCard({
    super.key,
    required this.stream,
    required this.imageName,
    required this.onTap,
  });

  @override
  StreamCardState createState() => StreamCardState();
}

class StreamCardState extends ConsumerState<StreamCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final progressAsyncValue = ref.watch(progressProvider(widget.stream.id));
    onTap() async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerPage(
            stream: widget.stream,
          ),
        ),
      );
      var _ = ref.refresh(progressProvider(widget.stream.id));
    }

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        shadowColor: themeData.shadowColor,
        color: themeData.cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: themeData
                    .inputDecorationTheme.enabledBorder?.borderSide.color
                    .withOpacity(0.2) ??
                Colors.grey.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: themeData.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(
                  title: widget.stream.name != '' ?  widget.stream.name : 'Lecture: ${DateFormat('EEEE. dd', Localizations.localeOf(context).toString())
                      .format(widget.stream.start.toDateTime())}',
                  subtitle: widget.stream.description,
                  length: widget.stream.duration,
                  themeData: themeData,
                ),
                _buildThumbnail(themeData),
                progressAsyncValue.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (e, st) => Text('Error: $e'),
                  data: (progress) => LinearProgressIndicator(
                    value: progress.progress,
                    minHeight: 10.0,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(ThemeData themeData) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            widget.imageName,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppImages.course1,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: _buildStreamLength(themeData),
        ),
      ],
    );
  }

  Widget _buildHeader({
    required String title,
    required String subtitle,
    int? length,
    Widget? trailing,
    required ThemeData themeData,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          if (length != null) _buildStreamDate(themeData),
          if (trailing != null) trailing,
        ],
      ),
    );
  }



  Widget _buildStreamDate(ThemeData themeData) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.focusColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Text(
        DateFormat('EEEE, MM/dd/yyyy, HH:mm')
            .format(widget.stream.start.toDateTime()),
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStreamLength(ThemeData themeData) {
    return Container(
      decoration: BoxDecoration(
        color: themeData.shadowColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        Tools.formatDuration(widget.stream.end.toDateTime().difference(widget.stream.start.toDateTime()).inMinutes),
        style: themeData.textTheme.labelSmall?.copyWith(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
