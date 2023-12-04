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
  static final _$getUserBookmarks =
      $grpc.ClientMethod<$0.GetBookmarksRequest, $0.GetBookmarksResponse>(
    '/protobuf.API/getUserBookmarks',
    ($0.GetBookmarksRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.GetBookmarksResponse.fromBuffer(value),
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
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCoursesResponse> getUserCourses(
      $0.GetUserCoursesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCourses, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserPinnedResponse> getUserPinned(
      $0.GetUserPinnedRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserPinned, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserAdminResponse> getUserAdminCourses(
      $0.GetUserAdminRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAdminCourses, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserSettingsResponse> getUserSettings(
      $0.GetUserSettingsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserSettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBookmarksResponse> getUserBookmarks(
      $0.GetBookmarksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserBookmarks, request, options: options);
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
  }

  $async.Future<$0.GetUserResponse> getUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetUserRequest> request) async {
    return getUser(call, await request);
  }

  $async.Future<$0.GetUserCoursesResponse> getUserCourses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserCoursesRequest> request) async {
    return getUserCourses(call, await request);
  }

  $async.Future<$0.GetUserPinnedResponse> getUserPinned_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserPinnedRequest> request) async {
    return getUserPinned(call, await request);
  }

  $async.Future<$0.GetUserAdminResponse> getUserAdminCourses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserAdminRequest> request) async {
    return getUserAdminCourses(call, await request);
  }

  $async.Future<$0.GetUserSettingsResponse> getUserSettings_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetUserSettingsRequest> request) async {
    return getUserSettings(call, await request);
  }

  $async.Future<$0.GetBookmarksResponse> getUserBookmarks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetBookmarksRequest> request) async {
    return getUserBookmarks(call, await request);
  }

  $async.Future<$0.GetUserResponse> getUser(
      $grpc.ServiceCall call, $0.GetUserRequest request);
  $async.Future<$0.GetUserCoursesResponse> getUserCourses(
      $grpc.ServiceCall call, $0.GetUserCoursesRequest request);
  $async.Future<$0.GetUserPinnedResponse> getUserPinned(
      $grpc.ServiceCall call, $0.GetUserPinnedRequest request);
  $async.Future<$0.GetUserAdminResponse> getUserAdminCourses(
      $grpc.ServiceCall call, $0.GetUserAdminRequest request);
  $async.Future<$0.GetUserSettingsResponse> getUserSettings(
      $grpc.ServiceCall call, $0.GetUserSettingsRequest request);
  $async.Future<$0.GetBookmarksResponse> getUserBookmarks(
      $grpc.ServiceCall call, $0.GetBookmarksRequest request);
}
