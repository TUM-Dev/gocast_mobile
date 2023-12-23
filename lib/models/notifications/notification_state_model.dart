import 'package:flutter/material.dart';
import 'package:gocast_mobile/base/networking/api/gocast/api_v2.pbgrpc.dart';
import 'package:gocast_mobile/models/error/error_model.dart';
import 'package:gocast_mobile/models/notifications/push_notification.dart';

@immutable
class NotificationState {
  final List<PushNotification>? pushNotifications;
  final bool isLoading;
  final List<FeatureNotification>? featureNotifications;
  final List<BannerAlert>? bannerAlerts;
  final AppError? error;

  const NotificationState({
    this.pushNotifications,
    this.isLoading = false,
    this.featureNotifications,
    this.bannerAlerts,
    this.error,
  });

  NotificationState copyWith({
    bool? isLoading,
    List<PushNotification>? pushNotifications,
    List<FeatureNotification>? featureNotifications,
    List<BannerAlert>? bannerAlerts,
    AppError? error,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      featureNotifications: featureNotifications ?? this.featureNotifications,
      bannerAlerts: bannerAlerts ?? this.bannerAlerts,
      error: error ?? this.error,
    );
  }

  NotificationState clearError({
    bool? isLoading,
    List<PushNotification>? pushNotifications,
    List<FeatureNotification>? featureNotifications,
    List<BannerAlert>? bannerAlerts,
    AppError? error,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      featureNotifications: featureNotifications ?? this.featureNotifications,
      bannerAlerts: bannerAlerts ?? this.bannerAlerts,
      error: null,
    );
  }

  void addPushNotification(PushNotification notification) {
    pushNotifications?.add(notification);
  }
}
