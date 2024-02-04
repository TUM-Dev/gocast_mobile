import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/chat/chat_state_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/chat_view/chat_view.dart';
import 'package:logger/logger.dart';

class ChatViewState extends ConsumerState<ChatView> {
  late ScrollController _scrollController;
  Timer? _updateTimer;
  bool _isCooldownActive = false;
  bool _isInitialScrollDone = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _updateTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) {
        if (widget.streamID != null) {
          ref
              .read(chatViewModelProvider.notifier)
              .fetchChatMessages(widget.streamID!);
        }
      }
    });
    if (widget.streamID != null) {
      Future.microtask(
        () => ref
            .read(chatViewModelProvider.notifier)
            .fetchChatMessages(widget.streamID!),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatViewModelProvider);
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (chatState.isRateLimitReached) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'You are sending messages too fast. Please wait a 10 seconds.',
            ),
          ),
        );
      });
    } else if (chatState.isCoolDown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'You are sending messages too fast. Please wait a 60 seconds.'),
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
      color: Theme.of(context).appBarTheme.backgroundColor,
      borderRadius: BorderRadius.circular(13),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 0.5,
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
      color: isSentByMe
          ? (isIOS ? CupertinoColors.activeBlue : Colors.blue)
          : (isIOS ? CupertinoColors.systemGrey6 : Colors.grey[300]),
      borderRadius: BorderRadius.circular(18),
    );
  }

  Widget buildMessageInputField(bool isIOS) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
      child: isIOS
          ? buildIOSMessageInputField(controller)
          : buildNonIOSMessageInputField(controller),
    );
  }

  Widget buildIOSMessageInputField(TextEditingController controller) {
    return CupertinoTextField(
      controller: controller,
      placeholder: _isCooldownActive
          ? 'Wait 30 seconds before sending another message'
          : 'Type a message...',
      enabled: !_isCooldownActive,
      suffix: GestureDetector(
        onTap: () => postMessage(context, ref, controller.text),
        child: _isCooldownActive
            ? const Icon(
                CupertinoIcons.arrow_up_circle_fill,
                color: CupertinoColors.systemGrey,
              )
            : const Icon(
                CupertinoIcons.arrow_up_circle_fill,
                color: CupertinoColors.activeBlue,
              ),
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    );
  }

  Widget buildNonIOSMessageInputField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: _isCooldownActive
            ? 'Wait 30 seconds before sending another message'
            : 'Type a message...',
        enabled: !_isCooldownActive,
        suffixIcon: GestureDetector(
          onTap: () => postMessage(context, ref, controller.text),
          child: _isCooldownActive
              ? const CircularProgressIndicator()
              : const Icon(Icons.send, color: Colors.blue),
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

  void postMessage(BuildContext context, WidgetRef ref, String message) {
    if (!_isCooldownActive && message.isNotEmpty && message.trim().isNotEmpty) {
      final int? streamId = widget.streamID;
      ref
          .read(chatViewModelProvider.notifier)
          .postChatMessage(streamId!, message);
      // Start cooldown
      Logger().i('Cooldown started');
      setState(() {
        _isCooldownActive = true;
      });
      Timer(const Duration(seconds: 30), () {
        if (mounted) {
          setState(() {
            _isCooldownActive = false;
          });
        }
      });
      Logger().i('Cooldown stopped');
    }
  }

  void _scrollToBottom() {
    if (!_isInitialScrollDone && mounted && _scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      _isInitialScrollDone = true;
    }
  }
}
