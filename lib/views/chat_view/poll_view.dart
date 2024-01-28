import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gocast_mobile/views/chat_view/poll_view_state.dart';

class PollView extends ConsumerStatefulWidget {
  final int? streamID;

  const PollView({
    super.key,
    this.streamID,
  });

  @override
  PollViewState createState() => PollViewState();
}
