import 'package:flutter/material.dart';

class ChatOverlay {
  static OverlayEntry createOverlayEntry(BuildContext context, TextEditingController chatController, VoidCallback onSend) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: chatController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Type your message here...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: onSend,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
