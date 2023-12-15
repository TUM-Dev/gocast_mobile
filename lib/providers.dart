import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/config/app_config.dart';
import 'package:gocast_mobile/models/user/user_state_model.dart';
import 'package:gocast_mobile/view_models/notification_view_model.dart';
import 'package:gocast_mobile/view_models/user_view_model.dart';

import 'base/networking/api/handler/grpc_handler.dart';

final grpcHandlerProvider =
    Provider((ref) => GrpcHandler(Routes.grpcHost, Routes.grpcPort));

final userViewModelProvider = StateNotifierProvider<UserViewModel, UserState>(
  (ref) => UserViewModel(ref.watch(grpcHandlerProvider)),
);

final notificationViewModelProvider = Provider<NotificationViewModel>(
  (ref) => NotificationViewModel(ref.watch(grpcHandlerProvider)),
);
