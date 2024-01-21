import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';

class StreamCard extends ConsumerStatefulWidget {
  final Stream stream;

  const StreamCard({super.key, required this.stream});

  @override
  StreamCardState createState() => StreamCardState();
}

class StreamCardState extends ConsumerState<StreamCard> {
  String imageName =
      'https://live.rbg.tum.de/thumb-fallback.png'; // Replace with your image URL

  @override
  void initState() {
    super.initState();
    final videoViewModelNotifier = ref.read(videoViewModelProvider.notifier);
    Future.microtask(() {
      videoViewModelNotifier.fetchProgress(widget.stream.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    onTap() {
      Navigator.push(
        context,
        MaterialPageRoute(
          //TODO - is chat enabled in live mode?
          builder: (context) => VideoPlayerPage(
            stream: widget.stream,
          ),
        ),
      );
    }
    final videoProgress = ref.watch(videoViewModelProvider).progress;

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        shadowColor: themeData.shadowColor.withOpacity(0.5),
        color: themeData.cardTheme.color,
        // Use card color from theme
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: themeData
                    .inputDecorationTheme.enabledBorder?.borderSide.color
                    .withOpacity(0.1) ??
                Colors.grey.withOpacity(0.1),
            width: 1.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(
                title: widget.stream.name,
                subtitle: widget.stream.description,
                length: widget.stream.duration,
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  imageName,
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
                      'assets/images/default_image.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ), // Adjust spacing as needed
              LinearProgressIndicator(
                value: videoProgress != null ? videoProgress.progress : 0.0,
                minHeight: 10.0,
                // Adjust the height of the progress bar
                backgroundColor: Colors.grey[300],
                // Change the background color
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.blue,
                ), // Change the fill color
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader({
    required String title,
    required String subtitle,
    int? length,
    Widget? trailing,
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
          if (length != null) _buildStreamLength(length),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  String formatDuration(int durationInMinutes) {
    int hours = durationInMinutes ~/ 60;
    int minutes = durationInMinutes % 60;
    int seconds = 0;

    String formattedHours = hours < 10 ? '0$hours' : '$hours';
    String formattedMinutes = minutes < 10 ? '0$minutes' : '$minutes';
    String formattedSeconds = seconds < 10 ? '0$seconds' : '$seconds';

    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  Widget _buildStreamLength(int length) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //themeData.shadowColor.withOpacity(0.15), //Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(3),
      child: Text(
        formatDuration(length),
        style: const TextStyle(
          //themeData.textTheme.labelSmall?.copyWith(
          fontSize: 12,
          //fontWeight: FontWeight.bold,
          //height: 1,
        ),
      ),
    );
  }
}

/*
class StreamCard extends BaseCard {
  final Stream stream;

  const StreamCard({
    super.key,
    required super.imageName,
    required this.stream,
    required super.onTap,
  });

  @override
  List<Widget> buildCardContent() {
    return [
      buildHeader(
        title: stream.name,
        subtitle: stream.description,
        length: stream.duration,
      ),
      buildInternetImage(),
    ];
  }
}
*/
