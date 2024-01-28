
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/chat_view/chat_view_state.dart';


class ChatView extends ConsumerStatefulWidget {
  final int? streamID;

  const ChatView({
    super.key,
     this.streamID,
  });

  @override
  ChatViewState createState() => ChatViewState();
}
