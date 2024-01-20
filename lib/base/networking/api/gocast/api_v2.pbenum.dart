//
//  Generated code. Do not modify.
//  source: gocast/api_v2.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class UserSettingType extends $pb.ProtobufEnum {
  static const UserSettingType PREFERRED_NAME = UserSettingType._(0, _omitEnumNames ? '' : 'PREFERRED_NAME');
  static const UserSettingType GREETING = UserSettingType._(1, _omitEnumNames ? '' : 'GREETING');
  static const UserSettingType CUSTOM_PLAYBACK_SPEEDS = UserSettingType._(2, _omitEnumNames ? '' : 'CUSTOM_PLAYBACK_SPEEDS');

  static const $core.List<UserSettingType> values = <UserSettingType> [
    PREFERRED_NAME,
    GREETING,
    CUSTOM_PLAYBACK_SPEEDS,
  ];

  static final $core.Map<$core.int, UserSettingType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UserSettingType? valueOf($core.int value) => _byValue[value];

  const UserSettingType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
