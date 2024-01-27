import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fixnum/fixnum.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/chat_view/suggested_streams_list.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';

class InactiveView extends ConsumerStatefulWidget {
  final int? streamID;

  const InactiveView({
    super.key,
    this.streamID,
  });

  @override
  InactiveViewState createState() => InactiveViewState();
}

class InactiveViewState extends ConsumerState<InactiveView> {
  @override
  void initState() {
    super.initState();
    // Initialize state here if needed
  }

  @override
  void dispose() {
    // Dispose resources if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);
    var suggestedStreams = ref.watch(videoViewModelProvider).streams ?? [];
    suggestedStreams = suggestedStreams
        .where((element) => element.id != widget.streamID)
        .toList();
    suggestedStreams
        .sort((a, b) => a.start.toDateTime().compareTo(b.start.toDateTime()));
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: isIOS
                ? CupertinoColors.systemBackground.withOpacity(0.9)
                : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            chatState.accessDenied
                ? 'Chat is disabled for this lecture'
                : 'Chat is Hidden',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SuggestedStreamsWidget(
            suggestedStreams: suggestedStreams,
            onStreamSelected: (Stream stream) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoPlayerPage(stream: stream)),
              );
            },
          ),
        ),
      ],
    );
  }
}
