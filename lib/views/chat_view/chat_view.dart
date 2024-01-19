
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/chat_view/chat_view_state.dart';


class ChatView extends ConsumerStatefulWidget {
  final bool isActive;
  final Int64? streamID;

  const ChatView({
    super.key,
    required this.isActive,
     this.streamID,
  });

  @override
  ChatViewState createState() => ChatViewState();
}


