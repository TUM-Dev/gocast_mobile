import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gocast_mobile/base/helpers/mock_data.dart';

class ChatView extends StatelessWidget {
  final bool isActive;

  const ChatView({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isActive
        ? buildActiveChat(context, isIOS)
        : buildInactiveChatOverlay(isIOS);
  }

  Widget buildActiveChat(BuildContext context, bool isIOS) {
    var chatDecoration = getChatDecoration(isIOS);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: chatDecoration,
      child: Stack(
        children: [
          buildMessagesList(isIOS),
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

  Widget buildMessagesList(bool isIOS) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: ListView.builder(
        itemCount: MockData.messages.length,
        itemBuilder: (context, index) {
          bool isSentByMe = index % 2 == 0;
          return buildMessageBubble(
            MockData.messages[index],
            isSentByMe,
            isIOS,
          );
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
      color: isSentByMe
          ? (isIOS ? CupertinoColors.activeBlue : Colors.blue)
          : (isIOS ? CupertinoColors.systemGrey5 : Colors.grey[300]),
      borderRadius: BorderRadius.circular(18),
    );
  }

  Widget buildMessageInputField(bool isIOS) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
      child:
          isIOS ? buildIOSMessageInputField() : buildNonIOSMessageInputField(),
    );
  }

  Widget buildIOSMessageInputField() {
    return CupertinoTextField(
      placeholder: 'Type a message...',
      suffix: const Icon(
        CupertinoIcons.arrow_right_circle_fill,
        color: CupertinoColors.activeBlue,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget buildNonIOSMessageInputField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Type a message...',
        suffixIcon: const Icon(Icons.send, color: Colors.blue),
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
        color: isIOS
            ? CupertinoColors.systemBackground.withOpacity(0.8)
            : Colors.white.withOpacity(0.8),
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
}
