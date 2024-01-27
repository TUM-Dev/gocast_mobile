import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/chat_view/poll_view.dart';

class PollViewState extends ConsumerState<PollView> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Poll View'),
      ),
      body: Center(
        child: Text('Poll view content goes here'),
      ),
    );
  }
}
