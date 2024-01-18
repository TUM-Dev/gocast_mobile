import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/models/chat/chat_state_model.dart';
import 'package:gocast_mobile/providers.dart';
import 'package:gocast_mobile/views/chat_view/chat_view_state.dart';
import 'package:gocast_mobile/views/chat_view/suggested_streams_list.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pb.dart';
import 'package:gocast_mobile/views/video_view/video_player.dart';
import 'package:logger/logger.dart';


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


