import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gocast_mobile/views/poll_view/poll_view_state.dart';

class PollView extends ConsumerStatefulWidget {
  final bool isActive;
  final Int64? streamID;

  const PollView({
    super.key,
    required this.isActive,
    this.streamID,
  });

  @override
  PollViewState createState() => PollViewState();
}
