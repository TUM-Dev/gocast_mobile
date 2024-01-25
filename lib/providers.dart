import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/config/app_config.dart';
import 'package:gocast_mobile/models/chat/chat_state_model.dart';
import 'package:gocast_mobile/models/course/course_state_model.dart';
import 'package:gocast_mobile/models/notifications/notification_state_model.dart';
import 'package:gocast_mobile/models/settings/setting_state_model.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/view_models/chat_view_model.dart';
import 'package:gocast_mobile/view_models/course_view_model.dart';
import 'package:gocast_mobile/view_models/notification_view_model.dart';
import 'package:gocast_mobile/view_models/download_view_model.dart';
import 'package:gocast_mobile/view_models/setting_view_model.dart';
import 'package:gocast_mobile/view_models/stream_view_model.dart';
import 'package:gocast_mobile/view_models/user_view_model.dart';
import 'base/networking/api/gocast/api_v2.pb.dart';
import 'base/networking/api/handler/grpc_handler.dart';
import 'models/download/download_state_model.dart';
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

final notificationViewModelProvider =
    StateNotifierProvider<NotificationViewModel, NotificationState>(
  (ref) => NotificationViewModel(ref.watch(grpcHandlerProvider)),
);

final currentIndexProvider = StateProvider<int>((ref) => 0);

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system; // Default to system theme
});

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, ChatState>(
  (ref) => ChatViewModel(ref.watch(grpcHandlerProvider)),
);

final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>(
  (ref) => CourseViewModel(ref.watch(grpcHandlerProvider)),
);

final downloadViewModelProvider =
    StateNotifierProvider<DownloadViewModel, DownloadState>((ref) {
  return DownloadViewModel();
});

final settingViewModelProvider =
    StateNotifierProvider<SettingViewModel, SettingState>((ref) {
  return SettingViewModel(ref.watch(grpcHandlerProvider));
});

final progressProvider = FutureProvider.autoDispose.family<Progress, Int64>(
      (ref, streamId) async {
    final videoViewModel = ref.watch(videoViewModelProvider.notifier);
    return videoViewModel.fetchProgressForStream(streamId);
  },
);


