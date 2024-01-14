import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/config/app_config.dart';
import 'package:gocast_mobile/models/chat/chat_state_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/view_models/chat_view_model.dart';
import 'package:gocast_mobile/view_models/stream_view_model.dart';
import 'package:gocast_mobile/view_models/user_view_model.dart';

import 'base/networking/api/handler/grpc_handler.dart';
import 'models/video/stream_state_model.dart';

final grpcHandlerProvider =
    Provider((ref) => GrpcHandler(Routes.grpcHost, Routes.grpcPort));

final userViewModelProvider = StateNotifierProvider<UserViewModel, UserState>(
  (ref) => UserViewModel(ref.watch(grpcHandlerProvider)),
);

final videoViewModelProvider =
    StateNotifierProvider<StreamViewModel, StreamState>(
  (ref) => StreamViewModel(ref.watch(grpcHandlerProvider)),
);

final currentIndexProvider = StateProvider<int>((ref) => 0);

final themeModeProvider = StateProvider<ThemeMode>((ref) {
    return ThemeMode.system; // Default to system theme
});

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>(
        (ref) => ChatViewModel(ref.watch(grpcHandlerProvider)),
);

