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
final $typed_data.Uint8List getUserRequestDescriptor = $convert.base64Decode(
  'Cg5HZXRVc2VyUmVxdWVzdA==',
);

@$core.Deprecated('Use getUserCoursesRequestDescriptor instead')
const GetUserCoursesRequest$json = {
  '1': 'GetUserCoursesRequest',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    {'1': 'term', '3': 2, '4': 1, '5': 9, '10': 'term'},
    {'1': 'query', '3': 3, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'skip', '3': 5, '4': 1, '5': 5, '10': 'skip'},
  ],
};

/// Descriptor for `GetUserCoursesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserCoursesRequestDescriptor = $convert.base64Decode(
    'ChVHZXRVc2VyQ291cnNlc1JlcXVlc3QSEgoEeWVhchgBIAEoBVIEeWVhchISCgR0ZXJtGAIgAS'
    'gJUgR0ZXJtEhQKBXF1ZXJ5GAMgASgJUgVxdWVyeRIUCgVsaW1pdBgEIAEoBVIFbGltaXQSEgoE'
    'c2tpcBgFIAEoBVIEc2tpcA==');

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
    $convert.base64Decode(
  'ChNHZXRVc2VyQWRtaW5SZXF1ZXN0',
);

@$core.Deprecated('Use getUserSettingsRequestDescriptor instead')
const GetUserSettingsRequest$json = {
  '1': 'GetUserSettingsRequest',
};

/// Descriptor for `GetUserSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserSettingsRequestDescriptor =
    $convert.base64Decode(
  'ChZHZXRVc2VyU2V0dGluZ3NSZXF1ZXN0',
);

@$core.Deprecated('Use getUserResponseDescriptor instead')
const GetUserResponse$json = {
  '1': 'GetUserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.protobuf.User', '10': 'user'},
  ],
};

/// Descriptor for `GetUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserResponseDescriptor = $convert.base64Decode(
  'Cg9HZXRVc2VyUmVzcG9uc2USIgoEdXNlchgBIAEoCzIOLnByb3RvYnVmLlVzZXJSBHVzZXI=',
);

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
  'ChNHZXRCb29rbWFya3NSZXF1ZXN0EhoKCHN0cmVhbUlEGAEgASgFUghzdHJlYW1JRA==',
);

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
    'ZWZlcmVuY2Vz');

@$core.Deprecated('Use semesterDescriptor instead')
const Semester$json = {
  '1': 'Semester',
  '2': [
    {'1': 'teachingTerm', '3': 3, '4': 1, '5': 9, '10': 'teachingTerm'},
    {'1': 'year', '3': 4, '4': 1, '5': 13, '10': 'year'},
  ],
};

/// Descriptor for `Semester`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List semesterDescriptor = $convert.base64Decode(
    'CghTZW1lc3RlchIiCgx0ZWFjaGluZ1Rlcm0YAyABKAlSDHRlYWNoaW5nVGVybRISCgR5ZWFyGA'
    'QgASgNUgR5ZWFy');

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
    'CWVuZE9mZnNldBgXIAEoDVIJZW5kT2Zmc2V0EhoKCGR1cmF0aW9uGBwgASgFUghkdXJhdGlvbg'
    '==');
