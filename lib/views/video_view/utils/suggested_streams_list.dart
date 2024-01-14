import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:intl/intl.dart';


class SuggestedStreamsWidget extends StatelessWidget {
  final List<Stream> suggestedStreams;
  final Function(Stream) onStreamSelected;

  const SuggestedStreamsWidget({
    super.key,
    required this.suggestedStreams,
    required this.onStreamSelected,
  });

  @override
  Widget build(BuildContext context) {
    return suggestedStreams.isNotEmpty
        ? ListView.builder(
      itemCount: suggestedStreams.length,
      itemBuilder: (context, index) {
        final stream = suggestedStreams[index];
        return ListTile(
          leading: const Icon(Icons.play_circle_outline),
          title: Text(stream.name),
          subtitle: Text(DateFormat('dd MMMM yyyy').format(stream.start.toDateTime())),
          onTap: () => onStreamSelected(stream),
        );
      },
    )
        : const Center(child: Text('No other Lectures available'));
  }
}
