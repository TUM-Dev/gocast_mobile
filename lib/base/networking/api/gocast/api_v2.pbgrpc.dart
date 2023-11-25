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
  static final _$getCourses =
      $grpc.ClientMethod<$0.getCoursesRequest, $0.getCoursesResponse>(
    '/protobuf.API/getCourses',
    ($0.getCoursesRequest value) => value.writeToBuffer(),
    ($core.List<$core.int> value) => $0.getCoursesResponse.fromBuffer(value),
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

  $grpc.ResponseFuture<$0.GetUserResponse> getUser(
    $0.GetUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.getCoursesResponse> getCourses(
    $0.getCoursesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getCourses, request, options: options);
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
      $grpc.ServiceMethod<$0.getCoursesRequest, $0.getCoursesResponse>(
        'getCourses',
        getCourses_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.getCoursesRequest.fromBuffer(value),
        ($0.getCoursesResponse value) => value.writeToBuffer(),
      ),
    );
  }

  $async.Future<$0.GetUserResponse> getUser_Pre(
    $grpc.ServiceCall call,
    $async.Future<$0.GetUserRequest> request,
  ) async {
    return getUser(call, await request);
  }

  $async.Future<$0.getCoursesResponse> getCourses_Pre(
    $grpc.ServiceCall call,
    $async.Future<$0.getCoursesRequest> request,
  ) async {
    return getCourses(call, await request);
  }

  $async.Future<$0.GetUserResponse> getUser(
    $grpc.ServiceCall call,
    $0.GetUserRequest request,
  );
  $async.Future<$0.getCoursesResponse> getCourses(
    $grpc.ServiceCall call,
    $0.getCoursesRequest request,
  );
}
