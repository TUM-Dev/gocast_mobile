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
    'CgtVc2VyU2V0dGluZxItCgR0eXBlGAMgASgOMhkucHJvdG9idWYuVXNlclNldHRpbmdUeXBlUg'
    'R0eXBlEhQKBXZhbHVlGAQgASgJUgV2YWx1ZQ==');

@$core.Deprecated('Use getUserRequestDescriptor instead')
const GetUserRequest$json = {
  '1': 'GetUserRequest',
};

/// Descriptor for `GetUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserRequestDescriptor =
    $convert.base64Decode('Cg5HZXRVc2VyUmVxdWVzdA==');

@$core.Deprecated('Use getUserCoursesRequestDescriptor instead')
const GetUserCoursesRequest$json = {
  '1': 'GetUserCoursesRequest',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    {'1': 'term', '3': 2, '4': 1, '5': 9, '10': 'term'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'skip', '3': 4, '4': 1, '5': 5, '10': 'skip'},
  ],
};

/// Descriptor for `GetUserCoursesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCoursesRequestDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyQ291cnNlc1JlcXVlc3QSEgoEeWVhchgBIAEoBVIEeWVhchISCgR0ZXJtGAIgAS'
    'gJUgR0ZXJtEhQKBWxpbWl0GAMgASgFUgVsaW1pdBISCgRza2lwGAQgASgFUgRza2lw');

@$core.Deprecated('Use getUserPinnedRequestDescriptor instead')
const GetUserPinnedRequest$json = {
  '1': 'GetUserPinnedRequest',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    {'1': 'term', '3': 2, '4': 1, '5': 9, '10': 'term'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'skip', '3': 4, '4': 1, '5': 5, '10': 'skip'},
  ],
};

/// Descriptor for `GetUserPinnedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPinnedRequestDescriptor = $convert.base64Decode(
    'ChRHZXRVc2VyUGlubmVkUmVxdWVzdBISCgR5ZWFyGAEgASgFUgR5ZWFyEhIKBHRlcm0YAiABKA'
    'lSBHRlcm0SFAoFbGltaXQYAyABKAVSBWxpbWl0EhIKBHNraXAYBCABKAVSBHNraXA=');

@$core.Deprecated('Use getUserAdminRequestDescriptor instead')
const GetUserAdminRequest$json = {
  '1': 'GetUserAdminRequest',
};

/// Descriptor for `GetUserAdminRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAdminRequestDescriptor =
    $convert.base64Decode('ChNHZXRVc2VyQWRtaW5SZXF1ZXN0');

@$core.Deprecated('Use getUserSettingsRequestDescriptor instead')
const GetUserSettingsRequest$json = {
  '1': 'GetUserSettingsRequest',
};

/// Descriptor for `GetUserSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserSettingsRequestDescriptor =
    $convert.base64Decode('ChZHZXRVc2VyU2V0dGluZ3NSZXF1ZXN0');

@$core.Deprecated('Use patchUserSettingsRequestDescriptor instead')
const PatchUserSettingsRequest$json = {
  '1': 'PatchUserSettingsRequest',
  '2': [
    {
      '1': 'userSettings',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.UserSetting',
      '10': 'userSettings'
    },
  ],
};

/// Descriptor for `PatchUserSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List patchUserSettingsRequestDescriptor =
    $convert.base64Decode(
        'ChhQYXRjaFVzZXJTZXR0aW5nc1JlcXVlc3QSOQoMdXNlclNldHRpbmdzGAEgAygLMhUucHJvdG'
        '9idWYuVXNlclNldHRpbmdSDHVzZXJTZXR0aW5ncw==');

@$core.Deprecated('Use patchUserSettingsResponseDescriptor instead')
const PatchUserSettingsResponse$json = {
  '1': 'PatchUserSettingsResponse',
  '2': [
    {
      '1': 'userSettings',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.UserSetting',
      '10': 'userSettings'
    },
  ],
};

/// Descriptor for `PatchUserSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List patchUserSettingsResponseDescriptor =
    $convert.base64Decode(
        'ChlQYXRjaFVzZXJTZXR0aW5nc1Jlc3BvbnNlEjkKDHVzZXJTZXR0aW5ncxgBIAMoCzIVLnByb3'
        'RvYnVmLlVzZXJTZXR0aW5nUgx1c2VyU2V0dGluZ3M=');

@$core.Deprecated('Use postPinnedRequestDescriptor instead')
const PostPinnedRequest$json = {
  '1': 'PostPinnedRequest',
  '2': [
    {'1': 'courseID', '3': 1, '4': 1, '5': 5, '10': 'courseID'},
  ],
};

/// Descriptor for `PostPinnedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postPinnedRequestDescriptor = $convert.base64Decode(
    'ChFQb3N0UGlubmVkUmVxdWVzdBIaCghjb3Vyc2VJRBgBIAEoBVIIY291cnNlSUQ=');

@$core.Deprecated('Use deletePinnedRequestDescriptor instead')
const DeletePinnedRequest$json = {
  '1': 'DeletePinnedRequest',
  '2': [
    {'1': 'courseID', '3': 1, '4': 1, '5': 5, '10': 'courseID'},
  ],
};

/// Descriptor for `DeletePinnedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePinnedRequestDescriptor =
    $convert.base64Decode(
        'ChNEZWxldGVQaW5uZWRSZXF1ZXN0EhoKCGNvdXJzZUlEGAEgASgFUghjb3Vyc2VJRA==');

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

@$core.Deprecated('Use getUserCoursesResponseDescriptor instead')
const GetUserCoursesResponse$json = {
  '1': 'GetUserCoursesResponse',
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

/// Descriptor for `GetUserCoursesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCoursesResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRVc2VyQ291cnNlc1Jlc3BvbnNlEioKB2NvdXJzZXMYASADKAsyEC5wcm90b2J1Zi5Db3'
        'Vyc2VSB2NvdXJzZXM=');

@$core.Deprecated('Use getUserPinnedResponseDescriptor instead')
const GetUserPinnedResponse$json = {
  '1': 'GetUserPinnedResponse',
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

/// Descriptor for `GetUserPinnedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserPinnedResponseDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyUGlubmVkUmVzcG9uc2USKgoHY291cnNlcxgBIAMoCzIQLnByb3RvYnVmLkNvdX'
    'JzZVIHY291cnNlcw==');

@$core.Deprecated('Use getUserAdminResponseDescriptor instead')
const GetUserAdminResponse$json = {
  '1': 'GetUserAdminResponse',
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

/// Descriptor for `GetUserAdminResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserAdminResponseDescriptor = $convert.base64Decode(
    'ChRHZXRVc2VyQWRtaW5SZXNwb25zZRIqCgdjb3Vyc2VzGAEgAygLMhAucHJvdG9idWYuQ291cn'
    'NlUgdjb3Vyc2Vz');

@$core.Deprecated('Use getUserSettingsResponseDescriptor instead')
const GetUserSettingsResponse$json = {
  '1': 'GetUserSettingsResponse',
  '2': [
    {
      '1': 'userSettings',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.UserSetting',
      '10': 'userSettings'
    },
  ],
};

/// Descriptor for `GetUserSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserSettingsResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRVc2VyU2V0dGluZ3NSZXNwb25zZRI5Cgx1c2VyU2V0dGluZ3MYASADKAsyFS5wcm90b2'
        'J1Zi5Vc2VyU2V0dGluZ1IMdXNlclNldHRpbmdz');

@$core.Deprecated('Use postPinnedResponseDescriptor instead')
const PostPinnedResponse$json = {
  '1': 'PostPinnedResponse',
};

/// Descriptor for `PostPinnedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postPinnedResponseDescriptor =
    $convert.base64Decode('ChJQb3N0UGlubmVkUmVzcG9uc2U=');

@$core.Deprecated('Use deletePinnedResponseDescriptor instead')
const DeletePinnedResponse$json = {
  '1': 'DeletePinnedResponse',
};

/// Descriptor for `DeletePinnedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePinnedResponseDescriptor =
    $convert.base64Decode('ChREZWxldGVQaW5uZWRSZXNwb25zZQ==');

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

@$core.Deprecated('Use getBookmarksRequestDescriptor instead')
const GetBookmarksRequest$json = {
  '1': 'GetBookmarksRequest',
  '2': [
    {'1': 'streamID', '3': 1, '4': 1, '5': 5, '10': 'streamID'},
  ],
};

/// Descriptor for `GetBookmarksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBookmarksRequestDescriptor =
    $convert.base64Decode(
        'ChNHZXRCb29rbWFya3NSZXF1ZXN0EhoKCHN0cmVhbUlEGAEgASgFUghzdHJlYW1JRA==');

@$core.Deprecated('Use putBookmarkRequestDescriptor instead')
const PutBookmarkRequest$json = {
  '1': 'PutBookmarkRequest',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    {'1': 'hours', '3': 2, '4': 1, '5': 13, '10': 'hours'},
    {'1': 'minutes', '3': 3, '4': 1, '5': 13, '10': 'minutes'},
    {'1': 'seconds', '3': 4, '4': 1, '5': 13, '10': 'seconds'},
    {'1': 'streamID', '3': 5, '4': 1, '5': 13, '10': 'streamID'},
  ],
};

/// Descriptor for `PutBookmarkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putBookmarkRequestDescriptor = $convert.base64Decode(
    'ChJQdXRCb29rbWFya1JlcXVlc3QSIAoLZGVzY3JpcHRpb24YASABKAlSC2Rlc2NyaXB0aW9uEh'
    'QKBWhvdXJzGAIgASgNUgVob3VycxIYCgdtaW51dGVzGAMgASgNUgdtaW51dGVzEhgKB3NlY29u'
    'ZHMYBCABKA1SB3NlY29uZHMSGgoIc3RyZWFtSUQYBSABKA1SCHN0cmVhbUlE');

@$core.Deprecated('Use patchBookmarkRequestDescriptor instead')
const PatchBookmarkRequest$json = {
  '1': 'PatchBookmarkRequest',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    {'1': 'hours', '3': 2, '4': 1, '5': 13, '10': 'hours'},
    {'1': 'minutes', '3': 3, '4': 1, '5': 13, '10': 'minutes'},
    {'1': 'seconds', '3': 4, '4': 1, '5': 13, '10': 'seconds'},
    {'1': 'bookmarkID', '3': 5, '4': 1, '5': 13, '10': 'bookmarkID'},
  ],
};

/// Descriptor for `PatchBookmarkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List patchBookmarkRequestDescriptor = $convert.base64Decode(
    'ChRQYXRjaEJvb2ttYXJrUmVxdWVzdBIgCgtkZXNjcmlwdGlvbhgBIAEoCVILZGVzY3JpcHRpb2'
    '4SFAoFaG91cnMYAiABKA1SBWhvdXJzEhgKB21pbnV0ZXMYAyABKA1SB21pbnV0ZXMSGAoHc2Vj'
    'b25kcxgEIAEoDVIHc2Vjb25kcxIeCgpib29rbWFya0lEGAUgASgNUgpib29rbWFya0lE');

@$core.Deprecated('Use deleteBookmarkRequestDescriptor instead')
const DeleteBookmarkRequest$json = {
  '1': 'DeleteBookmarkRequest',
  '2': [
    {'1': 'bookmarkID', '3': 1, '4': 1, '5': 13, '10': 'bookmarkID'},
  ],
};

/// Descriptor for `DeleteBookmarkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBookmarkRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVCb29rbWFya1JlcXVlc3QSHgoKYm9va21hcmtJRBgBIAEoDVIKYm9va21hcmtJRA'
    '==');

@$core.Deprecated('Use getBookmarksResponseDescriptor instead')
const GetBookmarksResponse$json = {
  '1': 'GetBookmarksResponse',
  '2': [
    {
      '1': 'bookmarks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Bookmark',
      '10': 'bookmarks'
    },
  ],
};

/// Descriptor for `GetBookmarksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBookmarksResponseDescriptor = $convert.base64Decode(
    'ChRHZXRCb29rbWFya3NSZXNwb25zZRIwCglib29rbWFya3MYASADKAsyEi5wcm90b2J1Zi5Cb2'
    '9rbWFya1IJYm9va21hcmtz');

@$core.Deprecated('Use putBookmarkResponseDescriptor instead')
const PutBookmarkResponse$json = {
  '1': 'PutBookmarkResponse',
  '2': [
    {
      '1': 'bookmark',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.protobuf.Bookmark',
      '10': 'bookmark'
    },
  ],
};

/// Descriptor for `PutBookmarkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putBookmarkResponseDescriptor = $convert.base64Decode(
    'ChNQdXRCb29rbWFya1Jlc3BvbnNlEi4KCGJvb2ttYXJrGAEgASgLMhIucHJvdG9idWYuQm9va2'
    '1hcmtSCGJvb2ttYXJr');

@$core.Deprecated('Use patchBookmarkResponseDescriptor instead')
const PatchBookmarkResponse$json = {
  '1': 'PatchBookmarkResponse',
  '2': [
    {
      '1': 'bookmark',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.protobuf.Bookmark',
      '10': 'bookmark'
    },
  ],
};

/// Descriptor for `PatchBookmarkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List patchBookmarkResponseDescriptor = $convert.base64Decode(
    'ChVQYXRjaEJvb2ttYXJrUmVzcG9uc2USLgoIYm9va21hcmsYASABKAsyEi5wcm90b2J1Zi5Cb2'
    '9rbWFya1IIYm9va21hcms=');

@$core.Deprecated('Use deleteBookmarkResponseDescriptor instead')
const DeleteBookmarkResponse$json = {
  '1': 'DeleteBookmarkResponse',
};

/// Descriptor for `DeleteBookmarkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteBookmarkResponseDescriptor =
    $convert.base64Decode('ChZEZWxldGVCb29rbWFya1Jlc3BvbnNl');

@$core.Deprecated('Use bannerAlertDescriptor instead')
const BannerAlert$json = {
  '1': 'BannerAlert',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'startsAt', '3': 2, '4': 1, '5': 9, '10': 'startsAt'},
    {'1': 'expiresAt', '3': 3, '4': 1, '5': 9, '10': 'expiresAt'},
    {'1': 'text', '3': 4, '4': 1, '5': 9, '10': 'text'},
    {'1': 'warn', '3': 5, '4': 1, '5': 8, '10': 'warn'},
  ],
};

/// Descriptor for `BannerAlert`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bannerAlertDescriptor = $convert.base64Decode(
    'CgtCYW5uZXJBbGVydBIOCgJpZBgBIAEoDVICaWQSGgoIc3RhcnRzQXQYAiABKAlSCHN0YXJ0c0'
    'F0EhwKCWV4cGlyZXNBdBgDIAEoCVIJZXhwaXJlc0F0EhIKBHRleHQYBCABKAlSBHRleHQSEgoE'
    'd2FybhgFIAEoCFIEd2Fybg==');

@$core.Deprecated('Use featureNotificationDescriptor instead')
const FeatureNotification$json = {
  '1': 'FeatureNotification',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'Title', '3': 2, '4': 1, '5': 9, '10': 'Title'},
    {'1': 'Body', '3': 3, '4': 1, '5': 9, '10': 'Body'},
    {'1': 'Target', '3': 4, '4': 1, '5': 13, '10': 'Target'},
  ],
};

/// Descriptor for `FeatureNotification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List featureNotificationDescriptor = $convert.base64Decode(
    'ChNGZWF0dXJlTm90aWZpY2F0aW9uEg4KAmlkGAEgASgNUgJpZBIUCgVUaXRsZRgCIAEoCVIFVG'
    'l0bGUSEgoEQm9keRgDIAEoCVIEQm9keRIWCgZUYXJnZXQYBCABKA1SBlRhcmdldA==');

@$core.Deprecated('Use postDeviceTokenRequestDescriptor instead')
const PostDeviceTokenRequest$json = {
  '1': 'PostDeviceTokenRequest',
  '2': [
    {'1': 'deviceToken', '3': 1, '4': 1, '5': 9, '10': 'deviceToken'},
  ],
};

/// Descriptor for `PostDeviceTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postDeviceTokenRequestDescriptor =
    $convert.base64Decode(
        'ChZQb3N0RGV2aWNlVG9rZW5SZXF1ZXN0EiAKC2RldmljZVRva2VuGAEgASgJUgtkZXZpY2VUb2'
        'tlbg==');

@$core.Deprecated('Use deleteDeviceTokenRequestDescriptor instead')
const DeleteDeviceTokenRequest$json = {
  '1': 'DeleteDeviceTokenRequest',
  '2': [
    {'1': 'deviceToken', '3': 1, '4': 1, '5': 9, '10': 'deviceToken'},
  ],
};

/// Descriptor for `DeleteDeviceTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDeviceTokenRequestDescriptor =
    $convert.base64Decode(
        'ChhEZWxldGVEZXZpY2VUb2tlblJlcXVlc3QSIAoLZGV2aWNlVG9rZW4YASABKAlSC2RldmljZV'
        'Rva2Vu');

@$core.Deprecated('Use getBannerAlertsRequestDescriptor instead')
const GetBannerAlertsRequest$json = {
  '1': 'GetBannerAlertsRequest',
};

/// Descriptor for `GetBannerAlertsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBannerAlertsRequestDescriptor =
    $convert.base64Decode('ChZHZXRCYW5uZXJBbGVydHNSZXF1ZXN0');

@$core.Deprecated('Use getFeatureNotificationsRequestDescriptor instead')
const GetFeatureNotificationsRequest$json = {
  '1': 'GetFeatureNotificationsRequest',
};

/// Descriptor for `GetFeatureNotificationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeatureNotificationsRequestDescriptor =
    $convert.base64Decode('Ch5HZXRGZWF0dXJlTm90aWZpY2F0aW9uc1JlcXVlc3Q=');

@$core.Deprecated('Use postDeviceTokenResponseDescriptor instead')
const PostDeviceTokenResponse$json = {
  '1': 'PostDeviceTokenResponse',
};

/// Descriptor for `PostDeviceTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List postDeviceTokenResponseDescriptor =
    $convert.base64Decode('ChdQb3N0RGV2aWNlVG9rZW5SZXNwb25zZQ==');

@$core.Deprecated('Use deleteDeviceTokenResponseDescriptor instead')
const DeleteDeviceTokenResponse$json = {
  '1': 'DeleteDeviceTokenResponse',
};

/// Descriptor for `DeleteDeviceTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDeviceTokenResponseDescriptor =
    $convert.base64Decode('ChlEZWxldGVEZXZpY2VUb2tlblJlc3BvbnNl');

@$core.Deprecated('Use getBannerAlertsResponseDescriptor instead')
const GetBannerAlertsResponse$json = {
  '1': 'GetBannerAlertsResponse',
  '2': [
    {
      '1': 'bannerAlerts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.BannerAlert',
      '10': 'bannerAlerts'
    },
  ],
};

/// Descriptor for `GetBannerAlertsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBannerAlertsResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRCYW5uZXJBbGVydHNSZXNwb25zZRI5CgxiYW5uZXJBbGVydHMYASADKAsyFS5wcm90b2'
        'J1Zi5CYW5uZXJBbGVydFIMYmFubmVyQWxlcnRz');

@$core.Deprecated('Use getFeatureNotificationsResponseDescriptor instead')
const GetFeatureNotificationsResponse$json = {
  '1': 'GetFeatureNotificationsResponse',
  '2': [
    {
      '1': 'featureNotifications',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.FeatureNotification',
      '10': 'featureNotifications'
    },
  ],
};

/// Descriptor for `GetFeatureNotificationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFeatureNotificationsResponseDescriptor =
    $convert.base64Decode(
        'Ch9HZXRGZWF0dXJlTm90aWZpY2F0aW9uc1Jlc3BvbnNlElEKFGZlYXR1cmVOb3RpZmljYXRpb2'
        '5zGAEgAygLMh0ucHJvdG9idWYuRmVhdHVyZU5vdGlmaWNhdGlvblIUZmVhdHVyZU5vdGlmaWNh'
        'dGlvbnM=');

@$core.Deprecated('Use courseDescriptor instead')
const Course$json = {
  '1': 'Course',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'slug', '3': 3, '4': 1, '5': 9, '10': 'slug'},
    {
      '1': 'semester',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.protobuf.Semester',
      '10': 'semester'
    },
    {
      '1': 'TUMOnlineIdentifier',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'TUMOnlineIdentifier'
    },
    {'1': 'VODEnabled', '3': 6, '4': 1, '5': 8, '10': 'VODEnabled'},
    {'1': 'downloadsEnabled', '3': 7, '4': 1, '5': 8, '10': 'downloadsEnabled'},
    {'1': 'chatEnabled', '3': 8, '4': 1, '5': 8, '10': 'chatEnabled'},
    {
      '1': 'anonymousChatEnabled',
      '3': 9,
      '4': 1,
      '5': 8,
      '10': 'anonymousChatEnabled'
    },
    {
      '1': 'moderatedChatEnabled',
      '3': 10,
      '4': 1,
      '5': 8,
      '10': 'moderatedChatEnabled'
    },
    {'1': 'vodChatEnabled', '3': 11, '4': 1, '5': 8, '10': 'vodChatEnabled'},
    {
      '1': 'streams',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Stream',
      '10': 'streams'
    },
    {
      '1': 'cameraPresetPreferences',
      '3': 13,
      '4': 1,
      '5': 9,
      '10': 'cameraPresetPreferences'
    },
    {
      '1': 'sourcePreferences',
      '3': 14,
      '4': 1,
      '5': 9,
      '10': 'sourcePreferences'
    },
    {'1': 'lastRecordingID', '3': 15, '4': 1, '5': 13, '10': 'lastRecordingID'},
    {'1': 'nextLectureID', '3': 16, '4': 1, '5': 13, '10': 'nextLectureID'},
  ],
};

/// Descriptor for `Course`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List courseDescriptor = $convert.base64Decode(
    'CgZDb3Vyc2USDgoCaWQYASABKA1SAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEc2x1ZxgDIA'
    'EoCVIEc2x1ZxIuCghzZW1lc3RlchgEIAEoCzISLnByb3RvYnVmLlNlbWVzdGVyUghzZW1lc3Rl'
    'chIwChNUVU1PbmxpbmVJZGVudGlmaWVyGAUgASgJUhNUVU1PbmxpbmVJZGVudGlmaWVyEh4KCl'
    'ZPREVuYWJsZWQYBiABKAhSClZPREVuYWJsZWQSKgoQZG93bmxvYWRzRW5hYmxlZBgHIAEoCFIQ'
    'ZG93bmxvYWRzRW5hYmxlZBIgCgtjaGF0RW5hYmxlZBgIIAEoCFILY2hhdEVuYWJsZWQSMgoUYW'
    '5vbnltb3VzQ2hhdEVuYWJsZWQYCSABKAhSFGFub255bW91c0NoYXRFbmFibGVkEjIKFG1vZGVy'
    'YXRlZENoYXRFbmFibGVkGAogASgIUhRtb2RlcmF0ZWRDaGF0RW5hYmxlZBImCg52b2RDaGF0RW'
    '5hYmxlZBgLIAEoCFIOdm9kQ2hhdEVuYWJsZWQSKgoHc3RyZWFtcxgMIAMoCzIQLnByb3RvYnVm'
    'LlN0cmVhbVIHc3RyZWFtcxI4ChdjYW1lcmFQcmVzZXRQcmVmZXJlbmNlcxgNIAEoCVIXY2FtZX'
    'JhUHJlc2V0UHJlZmVyZW5jZXMSLAoRc291cmNlUHJlZmVyZW5jZXMYDiABKAlSEXNvdXJjZVBy'
    'ZWZlcmVuY2VzEigKD2xhc3RSZWNvcmRpbmdJRBgPIAEoDVIPbGFzdFJlY29yZGluZ0lEEiQKDW'
    '5leHRMZWN0dXJlSUQYECABKA1SDW5leHRMZWN0dXJlSUQ=');

@$core.Deprecated('Use semesterDescriptor instead')
const Semester$json = {
  '1': 'Semester',
  '2': [
    {'1': 'teachingTerm', '3': 1, '4': 1, '5': 9, '10': 'teachingTerm'},
    {'1': 'year', '3': 2, '4': 1, '5': 13, '10': 'year'},
  ],
};

/// Descriptor for `Semester`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List semesterDescriptor = $convert.base64Decode(
    'CghTZW1lc3RlchIiCgx0ZWFjaGluZ1Rlcm0YASABKAlSDHRlYWNoaW5nVGVybRISCgR5ZWFyGA'
    'IgASgNUgR5ZWFy');

@$core.Deprecated('Use getPublicCoursesRequestDescriptor instead')
const GetPublicCoursesRequest$json = {
  '1': 'GetPublicCoursesRequest',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    {'1': 'term', '3': 2, '4': 1, '5': 9, '10': 'term'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'skip', '3': 4, '4': 1, '5': 5, '10': 'skip'},
  ],
};

/// Descriptor for `GetPublicCoursesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPublicCoursesRequestDescriptor = $convert.base64Decode(
    'ChdHZXRQdWJsaWNDb3Vyc2VzUmVxdWVzdBISCgR5ZWFyGAEgASgFUgR5ZWFyEhIKBHRlcm0YAi'
    'ABKAlSBHRlcm0SFAoFbGltaXQYAyABKAVSBWxpbWl0EhIKBHNraXAYBCABKAVSBHNraXA=');

@$core.Deprecated('Use getSemestersRequestDescriptor instead')
const GetSemestersRequest$json = {
  '1': 'GetSemestersRequest',
};

/// Descriptor for `GetSemestersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSemestersRequestDescriptor =
    $convert.base64Decode('ChNHZXRTZW1lc3RlcnNSZXF1ZXN0');

@$core.Deprecated('Use getCourseStreamsRequestDescriptor instead')
const GetCourseStreamsRequest$json = {
  '1': 'GetCourseStreamsRequest',
  '2': [
    {'1': 'courseID', '3': 1, '4': 1, '5': 5, '10': 'courseID'},
  ],
};

/// Descriptor for `GetCourseStreamsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCourseStreamsRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRDb3Vyc2VTdHJlYW1zUmVxdWVzdBIaCghjb3Vyc2VJRBgBIAEoBVIIY291cnNlSUQ=');

@$core.Deprecated('Use getPublicCoursesResponseDescriptor instead')
const GetPublicCoursesResponse$json = {
  '1': 'GetPublicCoursesResponse',
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

/// Descriptor for `GetPublicCoursesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPublicCoursesResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRQdWJsaWNDb3Vyc2VzUmVzcG9uc2USKgoHY291cnNlcxgBIAMoCzIQLnByb3RvYnVmLk'
        'NvdXJzZVIHY291cnNlcw==');

@$core.Deprecated('Use getSemestersResponseDescriptor instead')
const GetSemestersResponse$json = {
  '1': 'GetSemestersResponse',
  '2': [
    {
      '1': 'current',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.protobuf.Semester',
      '10': 'current'
    },
    {
      '1': 'semesters',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Semester',
      '10': 'semesters'
    },
  ],
};

/// Descriptor for `GetSemestersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSemestersResponseDescriptor = $convert.base64Decode(
    'ChRHZXRTZW1lc3RlcnNSZXNwb25zZRIsCgdjdXJyZW50GAEgASgLMhIucHJvdG9idWYuU2VtZX'
    'N0ZXJSB2N1cnJlbnQSMAoJc2VtZXN0ZXJzGAIgAygLMhIucHJvdG9idWYuU2VtZXN0ZXJSCXNl'
    'bWVzdGVycw==');

@$core.Deprecated('Use getCourseStreamsResponseDescriptor instead')
const GetCourseStreamsResponse$json = {
  '1': 'GetCourseStreamsResponse',
  '2': [
    {
      '1': 'streams',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Stream',
      '10': 'streams'
    },
  ],
};

/// Descriptor for `GetCourseStreamsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCourseStreamsResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRDb3Vyc2VTdHJlYW1zUmVzcG9uc2USKgoHc3RyZWFtcxgBIAMoCzIQLnByb3RvYnVmLl'
        'N0cmVhbVIHc3RyZWFtcw==');

@$core.Deprecated('Use streamDescriptor instead')
const Stream$json = {
  '1': 'Stream',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'courseID', '3': 4, '4': 1, '5': 13, '10': 'courseID'},
    {
      '1': 'start',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'start'
    },
    {
      '1': 'end',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'end'
    },
    {'1': 'chatEnabled', '3': 7, '4': 1, '5': 8, '10': 'chatEnabled'},
    {'1': 'roomName', '3': 8, '4': 1, '5': 9, '10': 'roomName'},
    {'1': 'roomCode', '3': 9, '4': 1, '5': 9, '10': 'roomCode'},
    {'1': 'eventTypeName', '3': 10, '4': 1, '5': 9, '10': 'eventTypeName'},
    {
      '1': 'TUMOnlineEventID',
      '3': 11,
      '4': 1,
      '5': 13,
      '10': 'TUMOnlineEventID'
    },
    {
      '1': 'seriesIdentifier',
      '3': 12,
      '4': 1,
      '5': 9,
      '10': 'seriesIdentifier'
    },
    {'1': 'playlistUrl', '3': 13, '4': 1, '5': 9, '10': 'playlistUrl'},
    {'1': 'playlistUrlPRES', '3': 14, '4': 1, '5': 9, '10': 'playlistUrlPRES'},
    {'1': 'playlistUrlCAM', '3': 15, '4': 1, '5': 9, '10': 'playlistUrlCAM'},
    {'1': 'liveNow', '3': 16, '4': 1, '5': 8, '10': 'liveNow'},
    {
      '1': 'liveNowTimestamp',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'liveNowTimestamp'
    },
    {'1': 'recording', '3': 18, '4': 1, '5': 8, '10': 'recording'},
    {'1': 'premiere', '3': 19, '4': 1, '5': 8, '10': 'premiere'},
    {'1': 'ended', '3': 20, '4': 1, '5': 8, '10': 'ended'},
    {'1': 'vodViews', '3': 21, '4': 1, '5': 13, '10': 'vodViews'},
    {'1': 'startOffset', '3': 22, '4': 1, '5': 13, '10': 'startOffset'},
    {'1': 'endOffset', '3': 23, '4': 1, '5': 13, '10': 'endOffset'},
    {'1': 'duration', '3': 28, '4': 1, '5': 5, '10': 'duration'},
    {
      '1': 'downloads',
      '3': 29,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Download',
      '10': 'downloads'
    },
    {'1': 'isPlanned', '3': 30, '4': 1, '5': 8, '10': 'isPlanned'},
    {'1': 'isComingUp', '3': 31, '4': 1, '5': 8, '10': 'isComingUp'},
    {'1': 'HLSUrl', '3': 32, '4': 1, '5': 9, '10': 'HLSUrl'},
  ],
};

/// Descriptor for `Stream`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamDescriptor = $convert.base64Decode(
    'CgZTdHJlYW0SDgoCaWQYASABKARSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSIAoLZGVzY3JpcH'
    'Rpb24YAyABKAlSC2Rlc2NyaXB0aW9uEhoKCGNvdXJzZUlEGAQgASgNUghjb3Vyc2VJRBIwCgVz'
    'dGFydBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBXN0YXJ0EiwKA2VuZBgGIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSA2VuZBIgCgtjaGF0RW5hYmxlZBgHIAEo'
    'CFILY2hhdEVuYWJsZWQSGgoIcm9vbU5hbWUYCCABKAlSCHJvb21OYW1lEhoKCHJvb21Db2RlGA'
    'kgASgJUghyb29tQ29kZRIkCg1ldmVudFR5cGVOYW1lGAogASgJUg1ldmVudFR5cGVOYW1lEioK'
    'EFRVTU9ubGluZUV2ZW50SUQYCyABKA1SEFRVTU9ubGluZUV2ZW50SUQSKgoQc2VyaWVzSWRlbn'
    'RpZmllchgMIAEoCVIQc2VyaWVzSWRlbnRpZmllchIgCgtwbGF5bGlzdFVybBgNIAEoCVILcGxh'
    'eWxpc3RVcmwSKAoPcGxheWxpc3RVcmxQUkVTGA4gASgJUg9wbGF5bGlzdFVybFBSRVMSJgoOcG'
    'xheWxpc3RVcmxDQU0YDyABKAlSDnBsYXlsaXN0VXJsQ0FNEhgKB2xpdmVOb3cYECABKAhSB2xp'
    'dmVOb3cSRgoQbGl2ZU5vd1RpbWVzdGFtcBgRIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3'
    'RhbXBSEGxpdmVOb3dUaW1lc3RhbXASHAoJcmVjb3JkaW5nGBIgASgIUglyZWNvcmRpbmcSGgoI'
    'cHJlbWllcmUYEyABKAhSCHByZW1pZXJlEhQKBWVuZGVkGBQgASgIUgVlbmRlZBIaCgh2b2RWaW'
    'V3cxgVIAEoDVIIdm9kVmlld3MSIAoLc3RhcnRPZmZzZXQYFiABKA1SC3N0YXJ0T2Zmc2V0EhwK'
    'CWVuZE9mZnNldBgXIAEoDVIJZW5kT2Zmc2V0EhoKCGR1cmF0aW9uGBwgASgFUghkdXJhdGlvbh'
    'IwCglkb3dubG9hZHMYHSADKAsyEi5wcm90b2J1Zi5Eb3dubG9hZFIJZG93bmxvYWRzEhwKCWlz'
    'UGxhbm5lZBgeIAEoCFIJaXNQbGFubmVkEh4KCmlzQ29taW5nVXAYHyABKAhSCmlzQ29taW5nVX'
    'ASFgoGSExTVXJsGCAgASgJUgZITFNVcmw=');

@$core.Deprecated('Use getStreamRequestDescriptor instead')
const GetStreamRequest$json = {
  '1': 'GetStreamRequest',
  '2': [
    {'1': 'streamID', '3': 1, '4': 1, '5': 4, '10': 'streamID'},
  ],
};

/// Descriptor for `GetStreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStreamRequestDescriptor = $convert.base64Decode(
    'ChBHZXRTdHJlYW1SZXF1ZXN0EhoKCHN0cmVhbUlEGAEgASgEUghzdHJlYW1JRA==');

@$core.Deprecated('Use getNowLiveRequestDescriptor instead')
const GetNowLiveRequest$json = {
  '1': 'GetNowLiveRequest',
};

/// Descriptor for `GetNowLiveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNowLiveRequestDescriptor =
    $convert.base64Decode('ChFHZXROb3dMaXZlUmVxdWVzdA==');

@$core.Deprecated('Use getThumbsLiveRequestDescriptor instead')
const GetThumbsLiveRequest$json = {
  '1': 'GetThumbsLiveRequest',
  '2': [
    {'1': 'streamID', '3': 1, '4': 1, '5': 4, '10': 'streamID'},
  ],
};

/// Descriptor for `GetThumbsLiveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getThumbsLiveRequestDescriptor =
    $convert.base64Decode(
        'ChRHZXRUaHVtYnNMaXZlUmVxdWVzdBIaCghzdHJlYW1JRBgBIAEoBFIIc3RyZWFtSUQ=');

@$core.Deprecated('Use getThumbsVODRequestDescriptor instead')
const GetThumbsVODRequest$json = {
  '1': 'GetThumbsVODRequest',
  '2': [
    {'1': 'streamID', '3': 1, '4': 1, '5': 4, '10': 'streamID'},
  ],
};

/// Descriptor for `GetThumbsVODRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getThumbsVODRequestDescriptor =
    $convert.base64Decode(
        'ChNHZXRUaHVtYnNWT0RSZXF1ZXN0EhoKCHN0cmVhbUlEGAEgASgEUghzdHJlYW1JRA==');

@$core.Deprecated('Use getStreamResponseDescriptor instead')
const GetStreamResponse$json = {
  '1': 'GetStreamResponse',
  '2': [
    {
      '1': 'stream',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.protobuf.Stream',
      '10': 'stream'
    },
  ],
};

/// Descriptor for `GetStreamResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStreamResponseDescriptor = $convert.base64Decode(
    'ChFHZXRTdHJlYW1SZXNwb25zZRIoCgZzdHJlYW0YASABKAsyEC5wcm90b2J1Zi5TdHJlYW1SBn'
    'N0cmVhbQ==');

@$core.Deprecated('Use getNowLiveResponseDescriptor instead')
const GetNowLiveResponse$json = {
  '1': 'GetNowLiveResponse',
  '2': [
    {
      '1': 'stream',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.protobuf.Stream',
      '10': 'stream'
    },
  ],
};

/// Descriptor for `GetNowLiveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNowLiveResponseDescriptor = $convert.base64Decode(
    'ChJHZXROb3dMaXZlUmVzcG9uc2USKAoGc3RyZWFtGAEgAygLMhAucHJvdG9idWYuU3RyZWFtUg'
    'ZzdHJlYW0=');

@$core.Deprecated('Use getThumbsVODResponseDescriptor instead')
const GetThumbsVODResponse$json = {
  '1': 'GetThumbsVODResponse',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `GetThumbsVODResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getThumbsVODResponseDescriptor = $convert
    .base64Decode('ChRHZXRUaHVtYnNWT0RSZXNwb25zZRISCgRwYXRoGAEgASgJUgRwYXRo');

@$core.Deprecated('Use getThumbsLiveResponseDescriptor instead')
const GetThumbsLiveResponse$json = {
  '1': 'GetThumbsLiveResponse',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
  ],
};

/// Descriptor for `GetThumbsLiveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getThumbsLiveResponseDescriptor =
    $convert.base64Decode(
        'ChVHZXRUaHVtYnNMaXZlUmVzcG9uc2USEgoEcGF0aBgBIAEoCVIEcGF0aA==');

@$core.Deprecated('Use downloadDescriptor instead')
const Download$json = {
  '1': 'Download',
  '2': [
    {'1': 'friendlyName', '3': 1, '4': 1, '5': 9, '10': 'friendlyName'},
    {'1': 'downloadURL', '3': 2, '4': 1, '5': 9, '10': 'downloadURL'},
  ],
};

/// Descriptor for `Download`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadDescriptor = $convert.base64Decode(
    'CghEb3dubG9hZBIiCgxmcmllbmRseU5hbWUYASABKAlSDGZyaWVuZGx5TmFtZRIgCgtkb3dubG'
    '9hZFVSTBgCIAEoCVILZG93bmxvYWRVUkw=');

@$core.Deprecated('Use progressDescriptor instead')
const Progress$json = {
  '1': 'Progress',
  '2': [
    {'1': 'progress', '3': 1, '4': 1, '5': 2, '10': 'progress'},
    {'1': 'watched', '3': 2, '4': 1, '5': 8, '10': 'watched'},
    {'1': 'userID', '3': 3, '4': 1, '5': 13, '10': 'userID'},
    {'1': 'streamID', '3': 4, '4': 1, '5': 13, '10': 'streamID'},
  ],
};

/// Descriptor for `Progress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List progressDescriptor = $convert.base64Decode(
    'CghQcm9ncmVzcxIaCghwcm9ncmVzcxgBIAEoAlIIcHJvZ3Jlc3MSGAoHd2F0Y2hlZBgCIAEoCF'
    'IHd2F0Y2hlZBIWCgZ1c2VySUQYAyABKA1SBnVzZXJJRBIaCghzdHJlYW1JRBgEIAEoDVIIc3Ry'
    'ZWFtSUQ=');

@$core.Deprecated('Use getProgressRequestDescriptor instead')
const GetProgressRequest$json = {
  '1': 'GetProgressRequest',
  '2': [
    {'1': 'streamID', '3': 1, '4': 1, '5': 4, '10': 'streamID'},
  ],
};

/// Descriptor for `GetProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProgressRequestDescriptor =
    $convert.base64Decode(
        'ChJHZXRQcm9ncmVzc1JlcXVlc3QSGgoIc3RyZWFtSUQYASABKARSCHN0cmVhbUlE');

@$core.Deprecated('Use putProgressRequestDescriptor instead')
const PutProgressRequest$json = {
  '1': 'PutProgressRequest',
  '2': [
    {'1': 'progress', '3': 1, '4': 1, '5': 2, '10': 'progress'},
    {'1': 'streamID', '3': 3, '4': 1, '5': 4, '10': 'streamID'},
  ],
};

/// Descriptor for `PutProgressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putProgressRequestDescriptor = $convert.base64Decode(
    'ChJQdXRQcm9ncmVzc1JlcXVlc3QSGgoIcHJvZ3Jlc3MYASABKAJSCHByb2dyZXNzEhoKCHN0cm'
    'VhbUlEGAMgASgEUghzdHJlYW1JRA==');

@$core.Deprecated('Use markAsWatchedRequestDescriptor instead')
const MarkAsWatchedRequest$json = {
  '1': 'MarkAsWatchedRequest',
  '2': [
    {'1': 'streamID', '3': 1, '4': 1, '5': 4, '10': 'streamID'},
  ],
};

/// Descriptor for `MarkAsWatchedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAsWatchedRequestDescriptor =
    $convert.base64Decode(
        'ChRNYXJrQXNXYXRjaGVkUmVxdWVzdBIaCghzdHJlYW1JRBgBIAEoBFIIc3RyZWFtSUQ=');

@$core.Deprecated('Use getProgressResponseDescriptor instead')
const GetProgressResponse$json = {
  '1': 'GetProgressResponse',
  '2': [
    {
      '1': 'progress',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.protobuf.Progress',
      '10': 'progress'
    },
  ],
};

/// Descriptor for `GetProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProgressResponseDescriptor = $convert.base64Decode(
    'ChNHZXRQcm9ncmVzc1Jlc3BvbnNlEi4KCHByb2dyZXNzGAEgASgLMhIucHJvdG9idWYuUHJvZ3'
    'Jlc3NSCHByb2dyZXNz');

@$core.Deprecated('Use putProgressResponseDescriptor instead')
const PutProgressResponse$json = {
  '1': 'PutProgressResponse',
  '2': [
    {
      '1': 'progress',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.protobuf.Progress',
      '10': 'progress'
    },
  ],
};

/// Descriptor for `PutProgressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List putProgressResponseDescriptor = $convert.base64Decode(
    'ChNQdXRQcm9ncmVzc1Jlc3BvbnNlEi4KCHByb2dyZXNzGAEgASgLMhIucHJvdG9idWYuUHJvZ3'
    'Jlc3NSCHByb2dyZXNz');

@$core.Deprecated('Use markAsWatchedResponseDescriptor instead')
const MarkAsWatchedResponse$json = {
  '1': 'MarkAsWatchedResponse',
  '2': [
    {
      '1': 'progress',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.protobuf.Progress',
      '10': 'progress'
    },
  ],
};

/// Descriptor for `MarkAsWatchedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAsWatchedResponseDescriptor = $convert.base64Decode(
    'ChVNYXJrQXNXYXRjaGVkUmVzcG9uc2USLgoIcHJvZ3Jlc3MYASABKAsyEi5wcm90b2J1Zi5Qcm'
    '9ncmVzc1IIcHJvZ3Jlc3M=');
