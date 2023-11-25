//
//  Generated code. Do not modify.
//  source: gocast/api_v2.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userSettingTypeDescriptor instead')
const UserSettingType$json = {
  '1': 'UserSettingType',
  '2': [
    {'1': 'PREFERRED_NAME', '2': 0},
    {'1': 'GREETING', '2': 1},
    {'1': 'CUSTOM_PLAYBACK_SPEEDS', '2': 2},
  ],
};

/// Descriptor for `UserSettingType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List userSettingTypeDescriptor = $convert.base64Decode(
    'Cg9Vc2VyU2V0dGluZ1R5cGUSEgoOUFJFRkVSUkVEX05BTUUQABIMCghHUkVFVElORxABEhoKFk'
    'NVU1RPTV9QTEFZQkFDS19TUEVFRFMQAg==');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'lastName', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {
      '1': 'matriculationNumber',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'matriculationNumber'
    },
    {'1': 'lrzID', '3': 6, '4': 1, '5': 9, '10': 'lrzID'},
    {'1': 'role', '3': 7, '4': 1, '5': 13, '10': 'role'},
    {
      '1': 'courses',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Course',
      '10': 'courses'
    },
    {
      '1': 'administeredCourses',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Course',
      '10': 'administeredCourses'
    },
    {
      '1': 'pinnedCourses',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Course',
      '10': 'pinnedCourses'
    },
    {
      '1': 'settings',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.protobuf.UserSetting',
      '10': 'settings'
    },
    {
      '1': 'bookmarks',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Bookmark',
      '10': 'bookmarks'
    },
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgNUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhoKCGxhc3ROYW1lGA'
    'MgASgJUghsYXN0TmFtZRIUCgVlbWFpbBgEIAEoCVIFZW1haWwSMAoTbWF0cmljdWxhdGlvbk51'
    'bWJlchgFIAEoCVITbWF0cmljdWxhdGlvbk51bWJlchIUCgVscnpJRBgGIAEoCVIFbHJ6SUQSEg'
    'oEcm9sZRgHIAEoDVIEcm9sZRIqCgdjb3Vyc2VzGAggAygLMhAucHJvdG9idWYuQ291cnNlUgdj'
    'b3Vyc2VzEkIKE2FkbWluaXN0ZXJlZENvdXJzZXMYCSADKAsyEC5wcm90b2J1Zi5Db3Vyc2VSE2'
    'FkbWluaXN0ZXJlZENvdXJzZXMSNgoNcGlubmVkQ291cnNlcxgKIAMoCzIQLnByb3RvYnVmLkNv'
    'dXJzZVINcGlubmVkQ291cnNlcxIxCghzZXR0aW5ncxgLIAMoCzIVLnByb3RvYnVmLlVzZXJTZX'
    'R0aW5nUghzZXR0aW5ncxIwCglib29rbWFya3MYDCADKAsyEi5wcm90b2J1Zi5Cb29rbWFya1IJ'
    'Ym9va21hcmtz');

@$core.Deprecated('Use userSettingDescriptor instead')
const UserSetting$json = {
  '1': 'UserSetting',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'userID', '3': 2, '4': 1, '5': 13, '10': 'userID'},
    {
      '1': 'type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.protobuf.UserSettingType',
      '10': 'type'
    },
    {'1': 'value', '3': 4, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `UserSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSettingDescriptor = $convert.base64Decode(
    'CgtVc2VyU2V0dGluZxIOCgJpZBgBIAEoDVICaWQSFgoGdXNlcklEGAIgASgNUgZ1c2VySUQSLQ'
    'oEdHlwZRgDIAEoDjIZLnByb3RvYnVmLlVzZXJTZXR0aW5nVHlwZVIEdHlwZRIUCgV2YWx1ZRgE'
    'IAEoCVIFdmFsdWU=');

@$core.Deprecated('Use getUserRequestDescriptor instead')
const GetUserRequest$json = {
  '1': 'GetUserRequest',
};

/// Descriptor for `GetUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserRequestDescriptor =
    $convert.base64Decode('Cg5HZXRVc2VyUmVxdWVzdA==');

@$core.Deprecated('Use getUserResponseDescriptor instead')
const GetUserResponse$json = {
  '1': 'GetUserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.protobuf.User', '10': 'user'},
  ],
};

/// Descriptor for `GetUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRVc2VyUmVzcG9uc2USIgoEdXNlchgBIAEoCzIOLnByb3RvYnVmLlVzZXJSBHVzZXI=');

@$core.Deprecated('Use bookmarkDescriptor instead')
const Bookmark$json = {
  '1': 'Bookmark',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'hours', '3': 3, '4': 1, '5': 13, '10': 'hours'},
    {'1': 'minutes', '3': 4, '4': 1, '5': 13, '10': 'minutes'},
    {'1': 'seconds', '3': 5, '4': 1, '5': 13, '10': 'seconds'},
    {'1': 'userID', '3': 6, '4': 1, '5': 13, '10': 'userID'},
    {'1': 'streamID', '3': 7, '4': 1, '5': 13, '10': 'streamID'},
  ],
};

/// Descriptor for `Bookmark`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bookmarkDescriptor = $convert.base64Decode(
    'CghCb29rbWFyaxIOCgJpZBgBIAEoDVICaWQSIAoLZGVzY3JpcHRpb24YAiABKAlSC2Rlc2NyaX'
    'B0aW9uEhQKBWhvdXJzGAMgASgNUgVob3VycxIYCgdtaW51dGVzGAQgASgNUgdtaW51dGVzEhgK'
    'B3NlY29uZHMYBSABKA1SB3NlY29uZHMSFgoGdXNlcklEGAYgASgNUgZ1c2VySUQSGgoIc3RyZW'
    'FtSUQYByABKA1SCHN0cmVhbUlE');

@$core.Deprecated('Use courseDescriptor instead')
const Course$json = {
  '1': 'Course',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'teachingTerm', '3': 3, '4': 1, '5': 9, '10': 'teachingTerm'},
    {'1': 'year', '3': 4, '4': 1, '5': 13, '10': 'year'},
  ],
};

/// Descriptor for `Course`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List courseDescriptor = $convert.base64Decode(
    'CgZDb3Vyc2USDgoCaWQYASABKARSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIgoMdGVhY2hpbm'
    'dUZXJtGAMgASgJUgx0ZWFjaGluZ1Rlcm0SEgoEeWVhchgEIAEoDVIEeWVhcg==');

@$core.Deprecated('Use getCoursesRequestDescriptor instead')
const getCoursesRequest$json = {
  '1': 'getCoursesRequest',
};

/// Descriptor for `getCoursesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCoursesRequestDescriptor =
    $convert.base64Decode('ChFnZXRDb3Vyc2VzUmVxdWVzdA==');

@$core.Deprecated('Use getCoursesResponseDescriptor instead')
const getCoursesResponse$json = {
  '1': 'getCoursesResponse',
  '2': [
    {
      '1': 'courses',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Course',
      '10': 'courses'
    },
  ],
};

/// Descriptor for `getCoursesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCoursesResponseDescriptor = $convert.base64Decode(
    'ChJnZXRDb3Vyc2VzUmVzcG9uc2USKgoHY291cnNlcxgBIAMoCzIQLnByb3RvYnVmLkNvdXJzZV'
    'IHY291cnNlcw==');
