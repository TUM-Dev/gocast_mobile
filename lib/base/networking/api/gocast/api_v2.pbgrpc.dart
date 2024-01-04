//
//  Generated code. Do not modify.
//  source: gocast/api_v2.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'api_v2.pb.dart' as $0;

export 'api_v2.pb.dart';

@$pb.GrpcServiceName('protobuf.API')
class APIClient extends $grpc.Client {
  static final _$getUser =
      $grpc.ClientMethod<$0.GetUserRequest, $0.GetUserResponse>(
    '/protobuf.API/getUser',
    ($0.GetUserRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetUserResponse.fromBuffer(value),
  );
  static final _$getUserCourses =
      $grpc.ClientMethod<$0.GetUserCoursesRequest, $0.GetUserCoursesResponse>(
    '/protobuf.API/getUserCourses',
    ($0.GetUserCoursesRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.GetUserCoursesResponse.fromBuffer(value),
  );
  static final _$getUserPinned =
      $grpc.ClientMethod<$0.GetUserPinnedRequest, $0.GetUserPinnedResponse>(
    '/protobuf.API/getUserPinned',
    ($0.GetUserPinnedRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetUserPinnedResponse.fromBuffer(value),
  );
  static final _$postUserPinned =
      $grpc.ClientMethod<$0.PostPinnedRequest, $0.PostPinnedResponse>(
    '/protobuf.API/postUserPinned',
    ($0.PostPinnedRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.PostPinnedResponse.fromBuffer(value),
  );
  static final _$deleteUserPinned =
      $grpc.ClientMethod<$0.DeletePinnedRequest, $0.DeletePinnedResponse>(
    '/protobuf.API/deleteUserPinned',
    ($0.DeletePinnedRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.DeletePinnedResponse.fromBuffer(value),
  );
  static final _$getUserAdminCourses =
      $grpc.ClientMethod<$0.GetUserAdminRequest, $0.GetUserAdminResponse>(
    '/protobuf.API/getUserAdminCourses',
    ($0.GetUserAdminRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetUserAdminResponse.fromBuffer(value),
  );
  static final _$getUserSettings =
      $grpc.ClientMethod<$0.GetUserSettingsRequest, $0.GetUserSettingsResponse>(
    '/protobuf.API/getUserSettings',
    ($0.GetUserSettingsRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.GetUserSettingsResponse.fromBuffer(value),
  );
  static final _$patchUserSettings = $grpc.ClientMethod<
      $0.PatchUserSettingsRequest, $0.PatchUserSettingsResponse>(
    '/protobuf.API/patchUserSettings',
    ($0.PatchUserSettingsRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.PatchUserSettingsResponse.fromBuffer(value),
  );
  static final _$getUserBookmarks =
      $grpc.ClientMethod<$0.GetBookmarksRequest, $0.GetBookmarksResponse>(
    '/protobuf.API/getUserBookmarks',
    ($0.GetBookmarksRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetBookmarksResponse.fromBuffer(value),
  );
  static final _$putUserBookmark =
      $grpc.ClientMethod<$0.PutBookmarkRequest, $0.PutBookmarkResponse>(
    '/protobuf.API/putUserBookmark',
    ($0.PutBookmarkRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.PutBookmarkResponse.fromBuffer(value),
  );
  static final _$patchUserBookmark =
      $grpc.ClientMethod<$0.PatchBookmarkRequest, $0.PatchBookmarkResponse>(
    '/protobuf.API/patchUserBookmark',
    ($0.PatchBookmarkRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.PatchBookmarkResponse.fromBuffer(value),
  );
  static final _$deleteUserBookmark =
      $grpc.ClientMethod<$0.DeleteBookmarkRequest, $0.DeleteBookmarkResponse>(
    '/protobuf.API/deleteUserBookmark',
    ($0.DeleteBookmarkRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.DeleteBookmarkResponse.fromBuffer(value),
  );
  static final _$getBannerAlerts =
      $grpc.ClientMethod<$0.GetBannerAlertsRequest, $0.GetBannerAlertsResponse>(
    '/protobuf.API/getBannerAlerts',
    ($0.GetBannerAlertsRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.GetBannerAlertsResponse.fromBuffer(value),
  );
  static final _$getFeatureNotifications = $grpc.ClientMethod<
      $0.GetFeatureNotificationsRequest, $0.GetFeatureNotificationsResponse>(
    '/protobuf.API/getFeatureNotifications',
    ($0.GetFeatureNotificationsRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.GetFeatureNotificationsResponse.fromBuffer(value),
  );
  static final _$postDeviceToken =
      $grpc.ClientMethod<$0.PostDeviceTokenRequest, $0.PostDeviceTokenResponse>(
    '/protobuf.API/postDeviceToken',
    ($0.PostDeviceTokenRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.PostDeviceTokenResponse.fromBuffer(value),
  );
  static final _$deleteDeviceToken = $grpc.ClientMethod<
      $0.DeleteDeviceTokenRequest, $0.DeleteDeviceTokenResponse>(
    '/protobuf.API/deleteDeviceToken',
    ($0.DeleteDeviceTokenRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.DeleteDeviceTokenResponse.fromBuffer(value),
  );
  static final _$getPublicCourses = $grpc.ClientMethod<
      $0.GetPublicCoursesRequest, $0.GetPublicCoursesResponse>(
    '/protobuf.API/getPublicCourses',
    ($0.GetPublicCoursesRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.GetPublicCoursesResponse.fromBuffer(value),
  );
  static final _$getSemesters =
      $grpc.ClientMethod<$0.GetSemestersRequest, $0.GetSemestersResponse>(
    '/protobuf.API/getSemesters',
    ($0.GetSemestersRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetSemestersResponse.fromBuffer(value),
  );
  static final _$getCourseStreams = $grpc.ClientMethod<
      $0.GetCourseStreamsRequest, $0.GetCourseStreamsResponse>(
    '/protobuf.API/getCourseStreams',
    ($0.GetCourseStreamsRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) =>
        $0.GetCourseStreamsResponse.fromBuffer(value),
  );
  static final _$getStream =
      $grpc.ClientMethod<$0.GetStreamRequest, $0.GetStreamResponse>(
    '/protobuf.API/GetStream',
    ($0.GetStreamRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetStreamResponse.fromBuffer(value),
  );
  static final _$getNowLive =
      $grpc.ClientMethod<$0.GetNowLiveRequest, $0.GetNowLiveResponse>(
    '/protobuf.API/GetNowLive',
    ($0.GetNowLiveRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetNowLiveResponse.fromBuffer(value),
  );
  static final _$getThumbsVOD =
      $grpc.ClientMethod<$0.GetThumbsVODRequest, $0.GetThumbsVODResponse>(
    '/protobuf.API/getThumbsVOD',
    ($0.GetThumbsVODRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetThumbsVODResponse.fromBuffer(value),
  );
  static final _$getThumbsLive =
      $grpc.ClientMethod<$0.GetThumbsLiveRequest, $0.GetThumbsLiveResponse>(
    '/protobuf.API/getThumbsLive',
    ($0.GetThumbsLiveRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetThumbsLiveResponse.fromBuffer(value),
  );
  static final _$getProgress =
      $grpc.ClientMethod<$0.GetProgressRequest, $0.GetProgressResponse>(
    '/protobuf.API/getProgress',
    ($0.GetProgressRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetProgressResponse.fromBuffer(value),
  );
  static final _$putProgress =
      $grpc.ClientMethod<$0.PutProgressRequest, $0.PutProgressResponse>(
    '/protobuf.API/putProgress',
    ($0.PutProgressRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.PutProgressResponse.fromBuffer(value),
  );
  static final _$markAsWatched =
      $grpc.ClientMethod<$0.MarkAsWatchedRequest, $0.MarkAsWatchedResponse>(
    '/protobuf.API/markAsWatched',
    ($0.MarkAsWatchedRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.MarkAsWatchedResponse.fromBuffer(value),
  );

  APIClient(
    $grpc.ClientChannel channel, {
    $grpc.CallOptions? options,
    $core.Iterable<$grpc.ClientInterceptor>? interceptors,
  }) : super(
          channel,
          options: options,
          interceptors: interceptors,
        );

  $grpc.ResponseFuture<$0.GetUserResponse> getUser($0.GetUserRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCoursesResponse> getUserCourses(
      $0.GetUserCoursesRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getUserCourses, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserPinnedResponse> getUserPinned(
      $0.GetUserPinnedRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getUserPinned, request, options: options);
  }

  $grpc.ResponseFuture<$0.PostPinnedResponse> postUserPinned(
      $0.PostPinnedRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$postUserPinned, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeletePinnedResponse> deleteUserPinned(
      $0.DeletePinnedRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$deleteUserPinned, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserAdminResponse> getUserAdminCourses(
      $0.GetUserAdminRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getUserAdminCourses, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserSettingsResponse> getUserSettings(
      $0.GetUserSettingsRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getUserSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.PatchUserSettingsResponse> patchUserSettings(
      $0.PatchUserSettingsRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$patchUserSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBookmarksResponse> getUserBookmarks(
      $0.GetBookmarksRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getUserBookmarks, request, options: options);
  }

  $grpc.ResponseFuture<$0.PutBookmarkResponse> putUserBookmark(
      $0.PutBookmarkRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$putUserBookmark, request, options: options);
  }

  $grpc.ResponseFuture<$0.PatchBookmarkResponse> patchUserBookmark(
      $0.PatchBookmarkRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$patchUserBookmark, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteBookmarkResponse> deleteUserBookmark(
      $0.DeleteBookmarkRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$deleteUserBookmark, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBannerAlertsResponse> getBannerAlerts(
      $0.GetBannerAlertsRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getBannerAlerts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFeatureNotificationsResponse>
      getFeatureNotifications($0.GetFeatureNotificationsRequest request,
          {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getFeatureNotifications, request,
        options: options,);
  }

  $grpc.ResponseFuture<$0.PostDeviceTokenResponse> postDeviceToken(
      $0.PostDeviceTokenRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$postDeviceToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteDeviceTokenResponse> deleteDeviceToken(
      $0.DeleteDeviceTokenRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$deleteDeviceToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPublicCoursesResponse> getPublicCourses(
      $0.GetPublicCoursesRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getPublicCourses, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSemestersResponse> getSemesters(
      $0.GetSemestersRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getSemesters, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCourseStreamsResponse> getCourseStreams(
      $0.GetCourseStreamsRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getCourseStreams, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetStreamResponse> getStream(
      $0.GetStreamRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getStream, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetNowLiveResponse> getNowLive(
      $0.GetNowLiveRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getNowLive, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetThumbsVODResponse> getThumbsVOD(
      $0.GetThumbsVODRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getThumbsVOD, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetThumbsLiveResponse> getThumbsLive(
      $0.GetThumbsLiveRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getThumbsLive, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetProgressResponse> getProgress(
      $0.GetProgressRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$getProgress, request, options: options);
  }

  $grpc.ResponseFuture<$0.PutProgressResponse> putProgress(
      $0.PutProgressRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$putProgress, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkAsWatchedResponse> markAsWatched(
      $0.MarkAsWatchedRequest request,
      {$grpc.CallOptions? options,}) {
    return $createUnaryCall(_$markAsWatched, request, options: options);
  }
}

@$pb.GrpcServiceName('protobuf.API')
abstract class APIServiceBase extends $grpc.Service {
  $core.String get $name => 'protobuf.API';

  APIServiceBase() {
    $addMethod(
      $grpc.ServiceMethod<$0.GetUserRequest, $0.GetUserResponse>(
        'getUser',
        getUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserRequest.fromBuffer(value),
        ($0.GetUserResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetUserCoursesRequest, $0.GetUserCoursesResponse>(
        'getUserCourses',
        getUserCourses_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserCoursesRequest.fromBuffer(value),
        ($0.GetUserCoursesResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetUserPinnedRequest, $0.GetUserPinnedResponse>(
        'getUserPinned',
        getUserPinned_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserPinnedRequest.fromBuffer(value),
        ($0.GetUserPinnedResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.PostPinnedRequest, $0.PostPinnedResponse>(
        'postUserPinned',
        postUserPinned_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PostPinnedRequest.fromBuffer(value),
        ($0.PostPinnedResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.DeletePinnedRequest, $0.DeletePinnedResponse>(
        'deleteUserPinned',
        deleteUserPinned_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeletePinnedRequest.fromBuffer(value),
        ($0.DeletePinnedResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetUserAdminRequest, $0.GetUserAdminResponse>(
        'getUserAdminCourses',
        getUserAdminCourses_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserAdminRequest.fromBuffer(value),
        ($0.GetUserAdminResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetUserSettingsRequest,
          $0.GetUserSettingsResponse>(
        'getUserSettings',
        getUserSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserSettingsRequest.fromBuffer(value),
        ($0.GetUserSettingsResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.PatchUserSettingsRequest,
          $0.PatchUserSettingsResponse>(
        'patchUserSettings',
        patchUserSettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PatchUserSettingsRequest.fromBuffer(value),
        ($0.PatchUserSettingsResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetBookmarksRequest, $0.GetBookmarksResponse>(
        'getUserBookmarks',
        getUserBookmarks_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBookmarksRequest.fromBuffer(value),
        ($0.GetBookmarksResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.PutBookmarkRequest, $0.PutBookmarkResponse>(
        'putUserBookmark',
        putUserBookmark_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PutBookmarkRequest.fromBuffer(value),
        ($0.PutBookmarkResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.PatchBookmarkRequest, $0.PatchBookmarkResponse>(
        'patchUserBookmark',
        patchUserBookmark_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PatchBookmarkRequest.fromBuffer(value),
        ($0.PatchBookmarkResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.DeleteBookmarkRequest, $0.DeleteBookmarkResponse>(
        'deleteUserBookmark',
        deleteUserBookmark_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteBookmarkRequest.fromBuffer(value),
        ($0.DeleteBookmarkResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetBannerAlertsRequest,
          $0.GetBannerAlertsResponse>(
        'getBannerAlerts',
        getBannerAlerts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetBannerAlertsRequest.fromBuffer(value),
        ($0.GetBannerAlertsResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetFeatureNotificationsRequest,
          $0.GetFeatureNotificationsResponse>(
        'getFeatureNotifications',
        getFeatureNotifications_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFeatureNotificationsRequest.fromBuffer(value),
        ($0.GetFeatureNotificationsResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.PostDeviceTokenRequest,
          $0.PostDeviceTokenResponse>(
        'postDeviceToken',
        postDeviceToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PostDeviceTokenRequest.fromBuffer(value),
        ($0.PostDeviceTokenResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.DeleteDeviceTokenRequest,
          $0.DeleteDeviceTokenResponse>(
        'deleteDeviceToken',
        deleteDeviceToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteDeviceTokenRequest.fromBuffer(value),
        ($0.DeleteDeviceTokenResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetPublicCoursesRequest,
          $0.GetPublicCoursesResponse>(
        'getPublicCourses',
        getPublicCourses_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPublicCoursesRequest.fromBuffer(value),
        ($0.GetPublicCoursesResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetSemestersRequest, $0.GetSemestersResponse>(
        'getSemesters',
        getSemesters_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSemestersRequest.fromBuffer(value),
        ($0.GetSemestersResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetCourseStreamsRequest,
          $0.GetCourseStreamsResponse>(
        'getCourseStreams',
        getCourseStreams_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetCourseStreamsRequest.fromBuffer(value),
        ($0.GetCourseStreamsResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetStreamRequest, $0.GetStreamResponse>(
        'GetStream',
        getStream_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetStreamRequest.fromBuffer(value),
        ($0.GetStreamResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetNowLiveRequest, $0.GetNowLiveResponse>(
        'GetNowLive',
        getNowLive_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetNowLiveRequest.fromBuffer(value),
        ($0.GetNowLiveResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetThumbsVODRequest, $0.GetThumbsVODResponse>(
        'getThumbsVOD',
        getThumbsVOD_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetThumbsVODRequest.fromBuffer(value),
        ($0.GetThumbsVODResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetThumbsLiveRequest, $0.GetThumbsLiveResponse>(
        'getThumbsLive',
        getThumbsLive_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetThumbsLiveRequest.fromBuffer(value),
        ($0.GetThumbsLiveResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.GetProgressRequest, $0.GetProgressResponse>(
        'getProgress',
        getProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetProgressRequest.fromBuffer(value),
        ($0.GetProgressResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.PutProgressRequest, $0.PutProgressResponse>(
        'putProgress',
        putProgress_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PutProgressRequest.fromBuffer(value),
        ($0.PutProgressResponse value) => value.writeToBuffer(),
      ),
    );
    $addMethod(
      $grpc.ServiceMethod<$0.MarkAsWatchedRequest, $0.MarkAsWatchedResponse>(
        'markAsWatched',
        markAsWatched_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.MarkAsWatchedRequest.fromBuffer(value),
        ($0.MarkAsWatchedResponse value) => value.writeToBuffer(),
      ),
    );
  }

  $async.Future<$0.GetUserResponse> getUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetUserRequest> request,) async {
    return getUser(call, await request);
  }

  $async.Future<$0.GetUserCoursesResponse> getUserCourses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserCoursesRequest> request,) async {
    return getUserCourses(call, await request);
  }

  $async.Future<$0.GetUserPinnedResponse> getUserPinned_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserPinnedRequest> request,) async {
    return getUserPinned(call, await request);
  }

  $async.Future<$0.PostPinnedResponse> postUserPinned_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PostPinnedRequest> request,) async {
    return postUserPinned(call, await request);
  }

  $async.Future<$0.DeletePinnedResponse> deleteUserPinned_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeletePinnedRequest> request,) async {
    return deleteUserPinned(call, await request);
  }

  $async.Future<$0.GetUserAdminResponse> getUserAdminCourses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserAdminRequest> request,) async {
    return getUserAdminCourses(call, await request);
  }

  $async.Future<$0.GetUserSettingsResponse> getUserSettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserSettingsRequest> request,) async {
    return getUserSettings(call, await request);
  }

  $async.Future<$0.PatchUserSettingsResponse> patchUserSettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PatchUserSettingsRequest> request,) async {
    return patchUserSettings(call, await request);
  }

  $async.Future<$0.GetBookmarksResponse> getUserBookmarks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBookmarksRequest> request,) async {
    return getUserBookmarks(call, await request);
  }

  $async.Future<$0.PutBookmarkResponse> putUserBookmark_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PutBookmarkRequest> request,) async {
    return putUserBookmark(call, await request);
  }

  $async.Future<$0.PatchBookmarkResponse> patchUserBookmark_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PatchBookmarkRequest> request,) async {
    return patchUserBookmark(call, await request);
  }

  $async.Future<$0.DeleteBookmarkResponse> deleteUserBookmark_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteBookmarkRequest> request,) async {
    return deleteUserBookmark(call, await request);
  }

  $async.Future<$0.GetBannerAlertsResponse> getBannerAlerts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBannerAlertsRequest> request,) async {
    return getBannerAlerts(call, await request);
  }

  $async.Future<$0.GetFeatureNotificationsResponse> getFeatureNotifications_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetFeatureNotificationsRequest> request,) async {
    return getFeatureNotifications(call, await request);
  }

  $async.Future<$0.PostDeviceTokenResponse> postDeviceToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PostDeviceTokenRequest> request,) async {
    return postDeviceToken(call, await request);
  }

  $async.Future<$0.DeleteDeviceTokenResponse> deleteDeviceToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteDeviceTokenRequest> request,) async {
    return deleteDeviceToken(call, await request);
  }

  $async.Future<$0.GetPublicCoursesResponse> getPublicCourses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetPublicCoursesRequest> request,) async {
    return getPublicCourses(call, await request);
  }

  $async.Future<$0.GetSemestersResponse> getSemesters_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetSemestersRequest> request,) async {
    return getSemesters(call, await request);
  }

  $async.Future<$0.GetCourseStreamsResponse> getCourseStreams_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetCourseStreamsRequest> request,) async {
    return getCourseStreams(call, await request);
  }

  $async.Future<$0.GetStreamResponse> getStream_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetStreamRequest> request,) async {
    return getStream(call, await request);
  }

  $async.Future<$0.GetNowLiveResponse> getNowLive_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetNowLiveRequest> request,) async {
    return getNowLive(call, await request);
  }

  $async.Future<$0.GetThumbsVODResponse> getThumbsVOD_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetThumbsVODRequest> request,) async {
    return getThumbsVOD(call, await request);
  }

  $async.Future<$0.GetThumbsLiveResponse> getThumbsLive_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetThumbsLiveRequest> request,) async {
    return getThumbsLive(call, await request);
  }

  $async.Future<$0.GetProgressResponse> getProgress_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetProgressRequest> request,) async {
    return getProgress(call, await request);
  }

  $async.Future<$0.PutProgressResponse> putProgress_Pre($grpc.ServiceCall call,
      $async.Future<$0.PutProgressRequest> request,) async {
    return putProgress(call, await request);
  }

  $async.Future<$0.MarkAsWatchedResponse> markAsWatched_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.MarkAsWatchedRequest> request,) async {
    return markAsWatched(call, await request);
  }

  $async.Future<$0.GetUserResponse> getUser(
      $grpc.ServiceCall call, $0.GetUserRequest request,);
  $async.Future<$0.GetUserCoursesResponse> getUserCourses(
      $grpc.ServiceCall call, $0.GetUserCoursesRequest request,);
  $async.Future<$0.GetUserPinnedResponse> getUserPinned(
      $grpc.ServiceCall call, $0.GetUserPinnedRequest request,);
  $async.Future<$0.PostPinnedResponse> postUserPinned(
      $grpc.ServiceCall call, $0.PostPinnedRequest request,);
  $async.Future<$0.DeletePinnedResponse> deleteUserPinned(
      $grpc.ServiceCall call, $0.DeletePinnedRequest request,);
  $async.Future<$0.GetUserAdminResponse> getUserAdminCourses(
      $grpc.ServiceCall call, $0.GetUserAdminRequest request,);
  $async.Future<$0.GetUserSettingsResponse> getUserSettings(
      $grpc.ServiceCall call, $0.GetUserSettingsRequest request,);
  $async.Future<$0.PatchUserSettingsResponse> patchUserSettings(
      $grpc.ServiceCall call, $0.PatchUserSettingsRequest request,);
  $async.Future<$0.GetBookmarksResponse> getUserBookmarks(
      $grpc.ServiceCall call, $0.GetBookmarksRequest request,);
  $async.Future<$0.PutBookmarkResponse> putUserBookmark(
      $grpc.ServiceCall call, $0.PutBookmarkRequest request,);
  $async.Future<$0.PatchBookmarkResponse> patchUserBookmark(
      $grpc.ServiceCall call, $0.PatchBookmarkRequest request,);
  $async.Future<$0.DeleteBookmarkResponse> deleteUserBookmark(
      $grpc.ServiceCall call, $0.DeleteBookmarkRequest request,);
  $async.Future<$0.GetBannerAlertsResponse> getBannerAlerts(
      $grpc.ServiceCall call, $0.GetBannerAlertsRequest request,);
  $async.Future<$0.GetFeatureNotificationsResponse> getFeatureNotifications(
      $grpc.ServiceCall call, $0.GetFeatureNotificationsRequest request,);
  $async.Future<$0.PostDeviceTokenResponse> postDeviceToken(
      $grpc.ServiceCall call, $0.PostDeviceTokenRequest request,);
  $async.Future<$0.DeleteDeviceTokenResponse> deleteDeviceToken(
      $grpc.ServiceCall call, $0.DeleteDeviceTokenRequest request,);
  $async.Future<$0.GetPublicCoursesResponse> getPublicCourses(
      $grpc.ServiceCall call, $0.GetPublicCoursesRequest request,);
  $async.Future<$0.GetSemestersResponse> getSemesters(
      $grpc.ServiceCall call, $0.GetSemestersRequest request,);
  $async.Future<$0.GetCourseStreamsResponse> getCourseStreams(
      $grpc.ServiceCall call, $0.GetCourseStreamsRequest request,);
  $async.Future<$0.GetStreamResponse> getStream(
      $grpc.ServiceCall call, $0.GetStreamRequest request,);
  $async.Future<$0.GetNowLiveResponse> getNowLive(
      $grpc.ServiceCall call, $0.GetNowLiveRequest request,);
  $async.Future<$0.GetThumbsVODResponse> getThumbsVOD(
      $grpc.ServiceCall call, $0.GetThumbsVODRequest request,);
  $async.Future<$0.GetThumbsLiveResponse> getThumbsLive(
      $grpc.ServiceCall call, $0.GetThumbsLiveRequest request,);
  $async.Future<$0.GetProgressResponse> getProgress(
      $grpc.ServiceCall call, $0.GetProgressRequest request,);
  $async.Future<$0.PutProgressResponse> putProgress(
      $grpc.ServiceCall call, $0.PutProgressRequest request,);
  $async.Future<$0.MarkAsWatchedResponse> markAsWatched(
      $grpc.ServiceCall call, $0.MarkAsWatchedRequest request,);
}
