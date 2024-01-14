import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/chat/chat_state_model.dart';
import 'package:gocast_mobile/providers.dart';

class ChatView extends ConsumerStatefulWidget {
  final bool isActive;
  final Int64 streamID;

  const ChatView({
    super.key,
    required this.isActive,
    required this.streamID,
  });

  @override
  ChatViewState createState() => ChatViewState();
}


class ChatViewState extends ConsumerState<ChatView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.microtask(
          () => ref.read(chatViewModelProvider.notifier).fetchChatMessages(widget.streamID),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if(chatState.isRateLimitReached){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are sending messages too fast. Please wait a few seconds.'),
          ),
        );
      });
    }
    return buildActiveChat(isIOS);
  }

  Widget buildActiveChat(bool isIOS) {
    final chatState = ref.watch(chatViewModelProvider);
    var chatDecoration = getChatDecoration(isIOS);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: chatDecoration,
      child: Stack(
        children: [
          buildMessagesList(chatState, isIOS),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildMessageInputField(isIOS),
          ),
        ],
      ),
    );
  }


  BoxDecoration getChatDecoration(bool isIOS) {
    return BoxDecoration(
      color: isIOS ? CupertinoColors.systemBackground : Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 4,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget buildMessagesList(ChatState chatState, bool isIOS) {
    final currentUserID = ref.watch(userViewModelProvider).user?.id;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: chatState.messages?.length ?? 0,
        itemBuilder: (context, index) {
          final message = chatState.messages![index];
          bool isSentByMe = int.parse(message.userID) == currentUserID;
          return buildMessageBubble(message.message, isSentByMe, isIOS);
        },
      ),
    );
  }

  Widget buildMessageBubble(String message, bool isSentByMe, bool isIOS) {
    var bubbleStyle = getMessageBubbleStyle(isSentByMe, isIOS);
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: bubbleStyle,
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
      ),
    );
  }

  BoxDecoration getMessageBubbleStyle(bool isSentByMe, bool isIOS) {
    return BoxDecoration(
      color: isSentByMe ? (isIOS ? CupertinoColors.activeBlue : Colors.blue) : (isIOS ? CupertinoColors.systemGrey5 : Colors.grey[300]),
      borderRadius: BorderRadius.circular(18),
    );
  }

  Widget buildMessageInputField(bool isIOS) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
      child: isIOS ? buildIOSMessageInputField(controller) : buildNonIOSMessageInputField(controller),
    );
  }

  Widget buildIOSMessageInputField(TextEditingController controller) {
    return CupertinoTextField(
      controller: controller,
      placeholder: 'Type a message...',
      suffix: GestureDetector(
        onTap: () => postMessage(context, ref, controller.text),
        child: const Icon(CupertinoIcons.arrow_right_circle_fill, color: CupertinoColors.activeBlue),
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget buildNonIOSMessageInputField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Type a message...',
        suffixIcon: GestureDetector(
          onTap: () => postMessage(context, ref, controller.text),
          child: const Icon(Icons.send, color: Colors.blue),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget buildInactiveChatOverlay(bool isIOS) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isIOS ? CupertinoColors.systemBackground.withOpacity(0.8) : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Chat is not active',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void postMessage(BuildContext context, WidgetRef ref, String message) {
    if (message.isNotEmpty && message.trim().isNotEmpty) {
      final Int64 streamId = widget.streamID;
      ref.read(chatViewModelProvider.notifier).postChatMessage(streamId, message);
    }
  }

  void _scrollToBottom() {
    if (mounted && _scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

}
