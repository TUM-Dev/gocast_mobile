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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $1;
import 'api_v2.pbenum.dart';

export 'api_v2.pbenum.dart';

class User extends $pb.GeneratedMessage {
  factory User({
    $core.int? id,
    $core.String? name,
    $core.String? lastName,
    $core.String? email,
    $core.String? matriculationNumber,
    $core.String? lrzID,
    $core.int? role,
    $core.Iterable<Course>? courses,
    $core.Iterable<Course>? administeredCourses,
    $core.Iterable<Course>? pinnedCourses,
    $core.Iterable<UserSetting>? settings,
    $core.Iterable<Bookmark>? bookmarks,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (email != null) {
      $result.email = email;
    }
    if (matriculationNumber != null) {
      $result.matriculationNumber = matriculationNumber;
    }
    if (lrzID != null) {
      $result.lrzID = lrzID;
    }
    if (role != null) {
      $result.role = role;
    }
    if (courses != null) {
      $result.courses.addAll(courses);
    }
    if (administeredCourses != null) {
      $result.administeredCourses.addAll(administeredCourses);
    }
    if (pinnedCourses != null) {
      $result.pinnedCourses.addAll(pinnedCourses);
    }
    if (settings != null) {
      $result.settings.addAll(settings);
    }
    if (bookmarks != null) {
      $result.bookmarks.addAll(bookmarks);
    }
    return $result;
  }
  User._() : super();
  factory User.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'lastName', protoName: 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'matriculationNumber',
        protoName: 'matriculationNumber')
    ..aOS(6, _omitFieldNames ? '' : 'lrzID', protoName: 'lrzID')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OU3)
    ..pc<Course>(8, _omitFieldNames ? '' : 'courses', $pb.PbFieldType.PM,
        subBuilder: Course.create)
    ..pc<Course>(
        9, _omitFieldNames ? '' : 'administeredCourses', $pb.PbFieldType.PM,
        protoName: 'administeredCourses', subBuilder: Course.create)
    ..pc<Course>(10, _omitFieldNames ? '' : 'pinnedCourses', $pb.PbFieldType.PM,
        protoName: 'pinnedCourses', subBuilder: Course.create)
    ..pc<UserSetting>(11, _omitFieldNames ? '' : 'settings', $pb.PbFieldType.PM,
        subBuilder: UserSetting.create)
    ..pc<Bookmark>(12, _omitFieldNames ? '' : 'bookmarks', $pb.PbFieldType.PM,
        subBuilder: Bookmark.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get matriculationNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set matriculationNumber($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMatriculationNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearMatriculationNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get lrzID => $_getSZ(5);
  @$pb.TagNumber(6)
  set lrzID($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasLrzID() => $_has(5);
  @$pb.TagNumber(6)
  void clearLrzID() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get role => $_getIZ(6);
  @$pb.TagNumber(7)
  set role($core.int v) {
    $_setUnsignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasRole() => $_has(6);
  @$pb.TagNumber(7)
  void clearRole() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<Course> get courses => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<Course> get administeredCourses => $_getList(8);

  @$pb.TagNumber(10)
  $core.List<Course> get pinnedCourses => $_getList(9);

  @$pb.TagNumber(11)
  $core.List<UserSetting> get settings => $_getList(10);

  @$pb.TagNumber(12)
  $core.List<Bookmark> get bookmarks => $_getList(11);
}

class UserSetting extends $pb.GeneratedMessage {
  factory UserSetting({
    $core.int? id,
    $core.int? userID,
    UserSettingType? type,
    $core.String? value,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    if (type != null) {
      $result.type = type;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  UserSetting._() : super();
  factory UserSetting.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserSetting.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSetting',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'userID', $pb.PbFieldType.OU3,
        protoName: 'userID')
    ..e<UserSettingType>(3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: UserSettingType.PREFERRED_NAME,
        valueOf: UserSettingType.valueOf,
        enumValues: UserSettingType.values)
    ..aOS(4, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserSetting clone() => UserSetting()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserSetting copyWith(void Function(UserSetting) updates) =>
      super.copyWith((message) => updates(message as UserSetting))
          as UserSetting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSetting create() => UserSetting._();
  UserSetting createEmptyInstance() => create();
  static $pb.PbList<UserSetting> createRepeated() => $pb.PbList<UserSetting>();
  @$core.pragma('dart2js:noInline')
  static UserSetting getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSetting>(create);
  static UserSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get userID => $_getIZ(1);
  @$pb.TagNumber(2)
  set userID($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);

  @$pb.TagNumber(3)
  UserSettingType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(UserSettingType v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get value => $_getSZ(3);
  @$pb.TagNumber(4)
  set value($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearValue() => clearField(4);
}

class GetUserRequest extends $pb.GeneratedMessage {
  factory GetUserRequest() => create();
  GetUserRequest._() : super();
  factory GetUserRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserRequest clone() => GetUserRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserRequest copyWith(void Function(GetUserRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserRequest))
          as GetUserRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserRequest create() => GetUserRequest._();
  GetUserRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserRequest> createRepeated() =>
      $pb.PbList<GetUserRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserRequest>(create);
  static GetUserRequest? _defaultInstance;
}

class GetUserCoursesRequest extends $pb.GeneratedMessage {
  factory GetUserCoursesRequest({
    $core.int? year,
    $core.String? term,
    $core.int? limit,
    $core.int? skip,
  }) {
    final $result = create();
    if (year != null) {
      $result.year = year;
    }
    if (term != null) {
      $result.term = term;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (skip != null) {
      $result.skip = skip;
    }
    return $result;
  }
  GetUserCoursesRequest._() : super();
  factory GetUserCoursesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserCoursesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserCoursesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'term')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'skip', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserCoursesRequest clone() =>
      GetUserCoursesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserCoursesRequest copyWith(
          void Function(GetUserCoursesRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserCoursesRequest))
          as GetUserCoursesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCoursesRequest create() => GetUserCoursesRequest._();
  GetUserCoursesRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserCoursesRequest> createRepeated() =>
      $pb.PbList<GetUserCoursesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserCoursesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserCoursesRequest>(create);
  static GetUserCoursesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get term => $_getSZ(1);
  @$pb.TagNumber(2)
  set term($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTerm() => $_has(1);
  @$pb.TagNumber(2)
  void clearTerm() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get skip => $_getIZ(3);
  @$pb.TagNumber(4)
  set skip($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSkip() => $_has(3);
  @$pb.TagNumber(4)
  void clearSkip() => clearField(4);
}

class GetUserPinnedRequest extends $pb.GeneratedMessage {
  factory GetUserPinnedRequest({
    $core.int? year,
    $core.String? term,
    $core.int? limit,
    $core.int? skip,
  }) {
    final $result = create();
    if (year != null) {
      $result.year = year;
    }
    if (term != null) {
      $result.term = term;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (skip != null) {
      $result.skip = skip;
    }
    return $result;
  }
  GetUserPinnedRequest._() : super();
  factory GetUserPinnedRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserPinnedRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserPinnedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'term')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'skip', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserPinnedRequest clone() =>
      GetUserPinnedRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserPinnedRequest copyWith(void Function(GetUserPinnedRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserPinnedRequest))
          as GetUserPinnedRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserPinnedRequest create() => GetUserPinnedRequest._();
  GetUserPinnedRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserPinnedRequest> createRepeated() =>
      $pb.PbList<GetUserPinnedRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserPinnedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserPinnedRequest>(create);
  static GetUserPinnedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get term => $_getSZ(1);
  @$pb.TagNumber(2)
  set term($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTerm() => $_has(1);
  @$pb.TagNumber(2)
  void clearTerm() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get skip => $_getIZ(3);
  @$pb.TagNumber(4)
  set skip($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSkip() => $_has(3);
  @$pb.TagNumber(4)
  void clearSkip() => clearField(4);
}

class GetUserAdminRequest extends $pb.GeneratedMessage {
  factory GetUserAdminRequest() => create();
  GetUserAdminRequest._() : super();
  factory GetUserAdminRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserAdminRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserAdminRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserAdminRequest clone() => GetUserAdminRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserAdminRequest copyWith(void Function(GetUserAdminRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserAdminRequest))
          as GetUserAdminRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAdminRequest create() => GetUserAdminRequest._();
  GetUserAdminRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserAdminRequest> createRepeated() =>
      $pb.PbList<GetUserAdminRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserAdminRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserAdminRequest>(create);
  static GetUserAdminRequest? _defaultInstance;
}

class GetUserSettingsRequest extends $pb.GeneratedMessage {
  factory GetUserSettingsRequest() => create();
  GetUserSettingsRequest._() : super();
  factory GetUserSettingsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserSettingsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserSettingsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserSettingsRequest clone() =>
      GetUserSettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserSettingsRequest copyWith(
          void Function(GetUserSettingsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserSettingsRequest))
          as GetUserSettingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserSettingsRequest create() => GetUserSettingsRequest._();
  GetUserSettingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserSettingsRequest> createRepeated() =>
      $pb.PbList<GetUserSettingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserSettingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserSettingsRequest>(create);
  static GetUserSettingsRequest? _defaultInstance;
}

class PostPinnedRequest extends $pb.GeneratedMessage {
  factory PostPinnedRequest({
    $core.int? courseID,
  }) {
    final $result = create();
    if (courseID != null) {
      $result.courseID = courseID;
    }
    return $result;
  }
  PostPinnedRequest._() : super();
  factory PostPinnedRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PostPinnedRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PostPinnedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'courseID', $pb.PbFieldType.O3,
        protoName: 'courseID')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PostPinnedRequest clone() => PostPinnedRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PostPinnedRequest copyWith(void Function(PostPinnedRequest) updates) =>
      super.copyWith((message) => updates(message as PostPinnedRequest))
          as PostPinnedRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PostPinnedRequest create() => PostPinnedRequest._();
  PostPinnedRequest createEmptyInstance() => create();
  static $pb.PbList<PostPinnedRequest> createRepeated() =>
      $pb.PbList<PostPinnedRequest>();
  @$core.pragma('dart2js:noInline')
  static PostPinnedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PostPinnedRequest>(create);
  static PostPinnedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get courseID => $_getIZ(0);
  @$pb.TagNumber(1)
  set courseID($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCourseID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCourseID() => clearField(1);
}

class DeletePinnedRequest extends $pb.GeneratedMessage {
  factory DeletePinnedRequest({
    $core.int? courseID,
  }) {
    final $result = create();
    if (courseID != null) {
      $result.courseID = courseID;
    }
    return $result;
  }
  DeletePinnedRequest._() : super();
  factory DeletePinnedRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeletePinnedRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeletePinnedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'courseID', $pb.PbFieldType.O3,
        protoName: 'courseID')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeletePinnedRequest clone() => DeletePinnedRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeletePinnedRequest copyWith(void Function(DeletePinnedRequest) updates) =>
      super.copyWith((message) => updates(message as DeletePinnedRequest))
          as DeletePinnedRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePinnedRequest create() => DeletePinnedRequest._();
  DeletePinnedRequest createEmptyInstance() => create();
  static $pb.PbList<DeletePinnedRequest> createRepeated() =>
      $pb.PbList<DeletePinnedRequest>();
  @$core.pragma('dart2js:noInline')
  static DeletePinnedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeletePinnedRequest>(create);
  static DeletePinnedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get courseID => $_getIZ(0);
  @$pb.TagNumber(1)
  set courseID($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCourseID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCourseID() => clearField(1);
}

class GetUserResponse extends $pb.GeneratedMessage {
  factory GetUserResponse({
    User? user,
  }) {
    final $result = create();
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  GetUserResponse._() : super();
  factory GetUserResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserResponse clone() => GetUserResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserResponse copyWith(void Function(GetUserResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserResponse))
          as GetUserResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserResponse create() => GetUserResponse._();
  GetUserResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserResponse> createRepeated() =>
      $pb.PbList<GetUserResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserResponse>(create);
  static GetUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class GetUserCoursesResponse extends $pb.GeneratedMessage {
  factory GetUserCoursesResponse({
    $core.Iterable<Course>? courses,
  }) {
    final $result = create();
    if (courses != null) {
      $result.courses.addAll(courses);
    }
    return $result;
  }
  GetUserCoursesResponse._() : super();
  factory GetUserCoursesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserCoursesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserCoursesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<Course>(1, _omitFieldNames ? '' : 'courses', $pb.PbFieldType.PM,
        subBuilder: Course.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserCoursesResponse clone() =>
      GetUserCoursesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserCoursesResponse copyWith(
          void Function(GetUserCoursesResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserCoursesResponse))
          as GetUserCoursesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserCoursesResponse create() => GetUserCoursesResponse._();
  GetUserCoursesResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserCoursesResponse> createRepeated() =>
      $pb.PbList<GetUserCoursesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserCoursesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserCoursesResponse>(create);
  static GetUserCoursesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Course> get courses => $_getList(0);
}

class GetUserPinnedResponse extends $pb.GeneratedMessage {
  factory GetUserPinnedResponse({
    $core.Iterable<Course>? courses,
  }) {
    final $result = create();
    if (courses != null) {
      $result.courses.addAll(courses);
    }
    return $result;
  }
  GetUserPinnedResponse._() : super();
  factory GetUserPinnedResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserPinnedResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserPinnedResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<Course>(1, _omitFieldNames ? '' : 'courses', $pb.PbFieldType.PM,
        subBuilder: Course.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserPinnedResponse clone() =>
      GetUserPinnedResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserPinnedResponse copyWith(
          void Function(GetUserPinnedResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserPinnedResponse))
          as GetUserPinnedResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserPinnedResponse create() => GetUserPinnedResponse._();
  GetUserPinnedResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserPinnedResponse> createRepeated() =>
      $pb.PbList<GetUserPinnedResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserPinnedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserPinnedResponse>(create);
  static GetUserPinnedResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Course> get courses => $_getList(0);
}

class GetUserAdminResponse extends $pb.GeneratedMessage {
  factory GetUserAdminResponse({
    $core.Iterable<Course>? courses,
  }) {
    final $result = create();
    if (courses != null) {
      $result.courses.addAll(courses);
    }
    return $result;
  }
  GetUserAdminResponse._() : super();
  factory GetUserAdminResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserAdminResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserAdminResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<Course>(1, _omitFieldNames ? '' : 'courses', $pb.PbFieldType.PM,
        subBuilder: Course.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserAdminResponse clone() =>
      GetUserAdminResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserAdminResponse copyWith(void Function(GetUserAdminResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserAdminResponse))
          as GetUserAdminResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserAdminResponse create() => GetUserAdminResponse._();
  GetUserAdminResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserAdminResponse> createRepeated() =>
      $pb.PbList<GetUserAdminResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserAdminResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserAdminResponse>(create);
  static GetUserAdminResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Course> get courses => $_getList(0);
}

class GetUserSettingsResponse extends $pb.GeneratedMessage {
  factory GetUserSettingsResponse({
    $core.Iterable<UserSetting>? userSettings,
  }) {
    final $result = create();
    if (userSettings != null) {
      $result.userSettings.addAll(userSettings);
    }
    return $result;
  }
  GetUserSettingsResponse._() : super();
  factory GetUserSettingsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetUserSettingsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserSettingsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<UserSetting>(
        1, _omitFieldNames ? '' : 'userSettings', $pb.PbFieldType.PM,
        protoName: 'userSettings', subBuilder: UserSetting.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetUserSettingsResponse clone() =>
      GetUserSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetUserSettingsResponse copyWith(
          void Function(GetUserSettingsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserSettingsResponse))
          as GetUserSettingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserSettingsResponse create() => GetUserSettingsResponse._();
  GetUserSettingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserSettingsResponse> createRepeated() =>
      $pb.PbList<GetUserSettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserSettingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserSettingsResponse>(create);
  static GetUserSettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserSetting> get userSettings => $_getList(0);
}

class PostPinnedResponse extends $pb.GeneratedMessage {
  factory PostPinnedResponse() => create();
  PostPinnedResponse._() : super();
  factory PostPinnedResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PostPinnedResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PostPinnedResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PostPinnedResponse clone() => PostPinnedResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PostPinnedResponse copyWith(void Function(PostPinnedResponse) updates) =>
      super.copyWith((message) => updates(message as PostPinnedResponse))
          as PostPinnedResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PostPinnedResponse create() => PostPinnedResponse._();
  PostPinnedResponse createEmptyInstance() => create();
  static $pb.PbList<PostPinnedResponse> createRepeated() =>
      $pb.PbList<PostPinnedResponse>();
  @$core.pragma('dart2js:noInline')
  static PostPinnedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PostPinnedResponse>(create);
  static PostPinnedResponse? _defaultInstance;
}

class DeletePinnedResponse extends $pb.GeneratedMessage {
  factory DeletePinnedResponse() => create();
  DeletePinnedResponse._() : super();
  factory DeletePinnedResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeletePinnedResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeletePinnedResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeletePinnedResponse clone() =>
      DeletePinnedResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeletePinnedResponse copyWith(void Function(DeletePinnedResponse) updates) =>
      super.copyWith((message) => updates(message as DeletePinnedResponse))
          as DeletePinnedResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePinnedResponse create() => DeletePinnedResponse._();
  DeletePinnedResponse createEmptyInstance() => create();
  static $pb.PbList<DeletePinnedResponse> createRepeated() =>
      $pb.PbList<DeletePinnedResponse>();
  @$core.pragma('dart2js:noInline')
  static DeletePinnedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeletePinnedResponse>(create);
  static DeletePinnedResponse? _defaultInstance;
}

class Bookmark extends $pb.GeneratedMessage {
  factory Bookmark({
    $core.int? id,
    $core.String? description,
    $core.int? hours,
    $core.int? minutes,
    $core.int? seconds,
    $core.int? userID,
    $core.int? streamID,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (description != null) {
      $result.description = description;
    }
    if (hours != null) {
      $result.hours = hours;
    }
    if (minutes != null) {
      $result.minutes = minutes;
    }
    if (seconds != null) {
      $result.seconds = seconds;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    if (streamID != null) {
      $result.streamID = streamID;
    }
    return $result;
  }
  Bookmark._() : super();
  factory Bookmark.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Bookmark.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Bookmark',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'hours', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'minutes', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'seconds', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'userID', $pb.PbFieldType.OU3,
        protoName: 'userID')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'streamID', $pb.PbFieldType.OU3,
        protoName: 'streamID')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Bookmark clone() => Bookmark()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Bookmark copyWith(void Function(Bookmark) updates) =>
      super.copyWith((message) => updates(message as Bookmark)) as Bookmark;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bookmark create() => Bookmark._();
  Bookmark createEmptyInstance() => create();
  static $pb.PbList<Bookmark> createRepeated() => $pb.PbList<Bookmark>();
  @$core.pragma('dart2js:noInline')
  static Bookmark getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bookmark>(create);
  static Bookmark? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get hours => $_getIZ(2);
  @$pb.TagNumber(3)
  set hours($core.int v) {
    $_setUnsignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasHours() => $_has(2);
  @$pb.TagNumber(3)
  void clearHours() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get minutes => $_getIZ(3);
  @$pb.TagNumber(4)
  set minutes($core.int v) {
    $_setUnsignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMinutes() => $_has(3);
  @$pb.TagNumber(4)
  void clearMinutes() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get seconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set seconds($core.int v) {
    $_setUnsignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearSeconds() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get userID => $_getIZ(5);
  @$pb.TagNumber(6)
  set userID($core.int v) {
    $_setUnsignedInt32(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasUserID() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserID() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get streamID => $_getIZ(6);
  @$pb.TagNumber(7)
  set streamID($core.int v) {
    $_setUnsignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasStreamID() => $_has(6);
  @$pb.TagNumber(7)
  void clearStreamID() => clearField(7);
}

class GetBookmarksRequest extends $pb.GeneratedMessage {
  factory GetBookmarksRequest({
    $core.int? streamID,
  }) {
    final $result = create();
    if (streamID != null) {
      $result.streamID = streamID;
    }
    return $result;
  }
  GetBookmarksRequest._() : super();
  factory GetBookmarksRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetBookmarksRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBookmarksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'streamID', $pb.PbFieldType.O3,
        protoName: 'streamID')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetBookmarksRequest clone() => GetBookmarksRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetBookmarksRequest copyWith(void Function(GetBookmarksRequest) updates) =>
      super.copyWith((message) => updates(message as GetBookmarksRequest))
          as GetBookmarksRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBookmarksRequest create() => GetBookmarksRequest._();
  GetBookmarksRequest createEmptyInstance() => create();
  static $pb.PbList<GetBookmarksRequest> createRepeated() =>
      $pb.PbList<GetBookmarksRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBookmarksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBookmarksRequest>(create);
  static GetBookmarksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get streamID => $_getIZ(0);
  @$pb.TagNumber(1)
  set streamID($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStreamID() => $_has(0);
  @$pb.TagNumber(1)
  void clearStreamID() => clearField(1);
}

class PutBookmarkRequest extends $pb.GeneratedMessage {
  factory PutBookmarkRequest({
    $core.String? description,
    $core.int? hours,
    $core.int? minutes,
    $core.int? seconds,
    $core.int? streamID,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (hours != null) {
      $result.hours = hours;
    }
    if (minutes != null) {
      $result.minutes = minutes;
    }
    if (seconds != null) {
      $result.seconds = seconds;
    }
    if (streamID != null) {
      $result.streamID = streamID;
    }
    return $result;
  }
  PutBookmarkRequest._() : super();
  factory PutBookmarkRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PutBookmarkRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PutBookmarkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'hours', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'minutes', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'seconds', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'streamID', $pb.PbFieldType.OU3,
        protoName: 'streamID')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PutBookmarkRequest clone() => PutBookmarkRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PutBookmarkRequest copyWith(void Function(PutBookmarkRequest) updates) =>
      super.copyWith((message) => updates(message as PutBookmarkRequest))
          as PutBookmarkRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PutBookmarkRequest create() => PutBookmarkRequest._();
  PutBookmarkRequest createEmptyInstance() => create();
  static $pb.PbList<PutBookmarkRequest> createRepeated() =>
      $pb.PbList<PutBookmarkRequest>();
  @$core.pragma('dart2js:noInline')
  static PutBookmarkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PutBookmarkRequest>(create);
  static PutBookmarkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get hours => $_getIZ(1);
  @$pb.TagNumber(2)
  set hours($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasHours() => $_has(1);
  @$pb.TagNumber(2)
  void clearHours() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get minutes => $_getIZ(2);
  @$pb.TagNumber(3)
  set minutes($core.int v) {
    $_setUnsignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMinutes() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinutes() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get seconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set seconds($core.int v) {
    $_setUnsignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeconds() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get streamID => $_getIZ(4);
  @$pb.TagNumber(5)
  set streamID($core.int v) {
    $_setUnsignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasStreamID() => $_has(4);
  @$pb.TagNumber(5)
  void clearStreamID() => clearField(5);
}

class PatchBookmarkRequest extends $pb.GeneratedMessage {
  factory PatchBookmarkRequest({
    $core.String? description,
    $core.int? hours,
    $core.int? minutes,
    $core.int? seconds,
    $core.int? bookmarkID,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (hours != null) {
      $result.hours = hours;
    }
    if (minutes != null) {
      $result.minutes = minutes;
    }
    if (seconds != null) {
      $result.seconds = seconds;
    }
    if (bookmarkID != null) {
      $result.bookmarkID = bookmarkID;
    }
    return $result;
  }
  PatchBookmarkRequest._() : super();
  factory PatchBookmarkRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PatchBookmarkRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PatchBookmarkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'hours', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'minutes', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'seconds', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'bookmarkID', $pb.PbFieldType.OU3,
        protoName: 'bookmarkID')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PatchBookmarkRequest clone() =>
      PatchBookmarkRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PatchBookmarkRequest copyWith(void Function(PatchBookmarkRequest) updates) =>
      super.copyWith((message) => updates(message as PatchBookmarkRequest))
          as PatchBookmarkRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PatchBookmarkRequest create() => PatchBookmarkRequest._();
  PatchBookmarkRequest createEmptyInstance() => create();
  static $pb.PbList<PatchBookmarkRequest> createRepeated() =>
      $pb.PbList<PatchBookmarkRequest>();
  @$core.pragma('dart2js:noInline')
  static PatchBookmarkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PatchBookmarkRequest>(create);
  static PatchBookmarkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get hours => $_getIZ(1);
  @$pb.TagNumber(2)
  set hours($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasHours() => $_has(1);
  @$pb.TagNumber(2)
  void clearHours() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get minutes => $_getIZ(2);
  @$pb.TagNumber(3)
  set minutes($core.int v) {
    $_setUnsignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMinutes() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinutes() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get seconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set seconds($core.int v) {
    $_setUnsignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeconds() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get bookmarkID => $_getIZ(4);
  @$pb.TagNumber(5)
  set bookmarkID($core.int v) {
    $_setUnsignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasBookmarkID() => $_has(4);
  @$pb.TagNumber(5)
  void clearBookmarkID() => clearField(5);
}

class DeleteBookmarkRequest extends $pb.GeneratedMessage {
  factory DeleteBookmarkRequest({
    $core.int? bookmarkID,
  }) {
    final $result = create();
    if (bookmarkID != null) {
      $result.bookmarkID = bookmarkID;
    }
    return $result;
  }
  DeleteBookmarkRequest._() : super();
  factory DeleteBookmarkRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteBookmarkRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteBookmarkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'bookmarkID', $pb.PbFieldType.OU3,
        protoName: 'bookmarkID')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteBookmarkRequest clone() =>
      DeleteBookmarkRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteBookmarkRequest copyWith(
          void Function(DeleteBookmarkRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteBookmarkRequest))
          as DeleteBookmarkRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBookmarkRequest create() => DeleteBookmarkRequest._();
  DeleteBookmarkRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteBookmarkRequest> createRepeated() =>
      $pb.PbList<DeleteBookmarkRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteBookmarkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteBookmarkRequest>(create);
  static DeleteBookmarkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get bookmarkID => $_getIZ(0);
  @$pb.TagNumber(1)
  set bookmarkID($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBookmarkID() => $_has(0);
  @$pb.TagNumber(1)
  void clearBookmarkID() => clearField(1);
}

class GetBookmarksResponse extends $pb.GeneratedMessage {
  factory GetBookmarksResponse({
    $core.Iterable<Bookmark>? bookmarks,
  }) {
    final $result = create();
    if (bookmarks != null) {
      $result.bookmarks.addAll(bookmarks);
    }
    return $result;
  }
  GetBookmarksResponse._() : super();
  factory GetBookmarksResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetBookmarksResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBookmarksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<Bookmark>(1, _omitFieldNames ? '' : 'bookmarks', $pb.PbFieldType.PM,
        subBuilder: Bookmark.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetBookmarksResponse clone() =>
      GetBookmarksResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetBookmarksResponse copyWith(void Function(GetBookmarksResponse) updates) =>
      super.copyWith((message) => updates(message as GetBookmarksResponse))
          as GetBookmarksResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBookmarksResponse create() => GetBookmarksResponse._();
  GetBookmarksResponse createEmptyInstance() => create();
  static $pb.PbList<GetBookmarksResponse> createRepeated() =>
      $pb.PbList<GetBookmarksResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBookmarksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBookmarksResponse>(create);
  static GetBookmarksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Bookmark> get bookmarks => $_getList(0);
}

class PutBookmarkResponse extends $pb.GeneratedMessage {
  factory PutBookmarkResponse({
    Bookmark? bookmark,
  }) {
    final $result = create();
    if (bookmark != null) {
      $result.bookmark = bookmark;
    }
    return $result;
  }
  PutBookmarkResponse._() : super();
  factory PutBookmarkResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PutBookmarkResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PutBookmarkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOM<Bookmark>(1, _omitFieldNames ? '' : 'bookmark',
        subBuilder: Bookmark.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PutBookmarkResponse clone() => PutBookmarkResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PutBookmarkResponse copyWith(void Function(PutBookmarkResponse) updates) =>
      super.copyWith((message) => updates(message as PutBookmarkResponse))
          as PutBookmarkResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PutBookmarkResponse create() => PutBookmarkResponse._();
  PutBookmarkResponse createEmptyInstance() => create();
  static $pb.PbList<PutBookmarkResponse> createRepeated() =>
      $pb.PbList<PutBookmarkResponse>();
  @$core.pragma('dart2js:noInline')
  static PutBookmarkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PutBookmarkResponse>(create);
  static PutBookmarkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Bookmark get bookmark => $_getN(0);
  @$pb.TagNumber(1)
  set bookmark(Bookmark v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBookmark() => $_has(0);
  @$pb.TagNumber(1)
  void clearBookmark() => clearField(1);
  @$pb.TagNumber(1)
  Bookmark ensureBookmark() => $_ensure(0);
}

class PatchBookmarkResponse extends $pb.GeneratedMessage {
  factory PatchBookmarkResponse({
    Bookmark? bookmark,
  }) {
    final $result = create();
    if (bookmark != null) {
      $result.bookmark = bookmark;
    }
    return $result;
  }
  PatchBookmarkResponse._() : super();
  factory PatchBookmarkResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PatchBookmarkResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PatchBookmarkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOM<Bookmark>(1, _omitFieldNames ? '' : 'bookmark',
        subBuilder: Bookmark.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PatchBookmarkResponse clone() =>
      PatchBookmarkResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PatchBookmarkResponse copyWith(
          void Function(PatchBookmarkResponse) updates) =>
      super.copyWith((message) => updates(message as PatchBookmarkResponse))
          as PatchBookmarkResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PatchBookmarkResponse create() => PatchBookmarkResponse._();
  PatchBookmarkResponse createEmptyInstance() => create();
  static $pb.PbList<PatchBookmarkResponse> createRepeated() =>
      $pb.PbList<PatchBookmarkResponse>();
  @$core.pragma('dart2js:noInline')
  static PatchBookmarkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PatchBookmarkResponse>(create);
  static PatchBookmarkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Bookmark get bookmark => $_getN(0);
  @$pb.TagNumber(1)
  set bookmark(Bookmark v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBookmark() => $_has(0);
  @$pb.TagNumber(1)
  void clearBookmark() => clearField(1);
  @$pb.TagNumber(1)
  Bookmark ensureBookmark() => $_ensure(0);
}

class DeleteBookmarkResponse extends $pb.GeneratedMessage {
  factory DeleteBookmarkResponse() => create();
  DeleteBookmarkResponse._() : super();
  factory DeleteBookmarkResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteBookmarkResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteBookmarkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteBookmarkResponse clone() =>
      DeleteBookmarkResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteBookmarkResponse copyWith(
          void Function(DeleteBookmarkResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteBookmarkResponse))
          as DeleteBookmarkResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBookmarkResponse create() => DeleteBookmarkResponse._();
  DeleteBookmarkResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteBookmarkResponse> createRepeated() =>
      $pb.PbList<DeleteBookmarkResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteBookmarkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteBookmarkResponse>(create);
  static DeleteBookmarkResponse? _defaultInstance;
}

class BannerAlert extends $pb.GeneratedMessage {
  factory BannerAlert({
    $core.int? id,
    $core.String? startsAt,
    $core.String? expiresAt,
    $core.String? text,
    $core.bool? warn,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (startsAt != null) {
      $result.startsAt = startsAt;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (text != null) {
      $result.text = text;
    }
    if (warn != null) {
      $result.warn = warn;
    }
    return $result;
  }
  BannerAlert._() : super();
  factory BannerAlert.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BannerAlert.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BannerAlert',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'startsAt', protoName: 'startsAt')
    ..aOS(3, _omitFieldNames ? '' : 'expiresAt', protoName: 'expiresAt')
    ..aOS(4, _omitFieldNames ? '' : 'text')
    ..aOB(5, _omitFieldNames ? '' : 'warn')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BannerAlert clone() => BannerAlert()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BannerAlert copyWith(void Function(BannerAlert) updates) =>
      super.copyWith((message) => updates(message as BannerAlert))
          as BannerAlert;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BannerAlert create() => BannerAlert._();
  BannerAlert createEmptyInstance() => create();
  static $pb.PbList<BannerAlert> createRepeated() => $pb.PbList<BannerAlert>();
  @$core.pragma('dart2js:noInline')
  static BannerAlert getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BannerAlert>(create);
  static BannerAlert? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get startsAt => $_getSZ(1);
  @$pb.TagNumber(2)
  set startsAt($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStartsAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartsAt() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get expiresAt => $_getSZ(2);
  @$pb.TagNumber(3)
  set expiresAt($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get text => $_getSZ(3);
  @$pb.TagNumber(4)
  set text($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasText() => $_has(3);
  @$pb.TagNumber(4)
  void clearText() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get warn => $_getBF(4);
  @$pb.TagNumber(5)
  set warn($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasWarn() => $_has(4);
  @$pb.TagNumber(5)
  void clearWarn() => clearField(5);
}

class FeatureNotification extends $pb.GeneratedMessage {
  factory FeatureNotification({
    $core.int? id,
    $core.String? title,
    $core.String? body,
    $core.int? target,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (body != null) {
      $result.body = body;
    }
    if (target != null) {
      $result.target = target;
    }
    return $result;
  }
  FeatureNotification._() : super();
  factory FeatureNotification.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FeatureNotification.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeatureNotification',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'Title', protoName: 'Title')
    ..aOS(3, _omitFieldNames ? '' : 'Body', protoName: 'Body')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'Target', $pb.PbFieldType.OU3,
        protoName: 'Target')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FeatureNotification clone() => FeatureNotification()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FeatureNotification copyWith(void Function(FeatureNotification) updates) =>
      super.copyWith((message) => updates(message as FeatureNotification))
          as FeatureNotification;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeatureNotification create() => FeatureNotification._();
  FeatureNotification createEmptyInstance() => create();
  static $pb.PbList<FeatureNotification> createRepeated() =>
      $pb.PbList<FeatureNotification>();
  @$core.pragma('dart2js:noInline')
  static FeatureNotification getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeatureNotification>(create);
  static FeatureNotification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get body => $_getSZ(2);
  @$pb.TagNumber(3)
  set body($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(2);
  @$pb.TagNumber(3)
  void clearBody() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get target => $_getIZ(3);
  @$pb.TagNumber(4)
  set target($core.int v) {
    $_setUnsignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasTarget() => $_has(3);
  @$pb.TagNumber(4)
  void clearTarget() => clearField(4);
}

class PostDeviceTokenRequest extends $pb.GeneratedMessage {
  factory PostDeviceTokenRequest({
    $core.String? deviceToken,
  }) {
    final $result = create();
    if (deviceToken != null) {
      $result.deviceToken = deviceToken;
    }
    return $result;
  }
  PostDeviceTokenRequest._() : super();
  factory PostDeviceTokenRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PostDeviceTokenRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PostDeviceTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceToken', protoName: 'deviceToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PostDeviceTokenRequest clone() =>
      PostDeviceTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PostDeviceTokenRequest copyWith(
          void Function(PostDeviceTokenRequest) updates) =>
      super.copyWith((message) => updates(message as PostDeviceTokenRequest))
          as PostDeviceTokenRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PostDeviceTokenRequest create() => PostDeviceTokenRequest._();
  PostDeviceTokenRequest createEmptyInstance() => create();
  static $pb.PbList<PostDeviceTokenRequest> createRepeated() =>
      $pb.PbList<PostDeviceTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static PostDeviceTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PostDeviceTokenRequest>(create);
  static PostDeviceTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceToken($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceToken() => clearField(1);
}

class DeleteDeviceTokenRequest extends $pb.GeneratedMessage {
  factory DeleteDeviceTokenRequest({
    $core.String? deviceToken,
  }) {
    final $result = create();
    if (deviceToken != null) {
      $result.deviceToken = deviceToken;
    }
    return $result;
  }
  DeleteDeviceTokenRequest._() : super();
  factory DeleteDeviceTokenRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteDeviceTokenRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteDeviceTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceToken', protoName: 'deviceToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteDeviceTokenRequest clone() =>
      DeleteDeviceTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteDeviceTokenRequest copyWith(
          void Function(DeleteDeviceTokenRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteDeviceTokenRequest))
          as DeleteDeviceTokenRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteDeviceTokenRequest create() => DeleteDeviceTokenRequest._();
  DeleteDeviceTokenRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteDeviceTokenRequest> createRepeated() =>
      $pb.PbList<DeleteDeviceTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteDeviceTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteDeviceTokenRequest>(create);
  static DeleteDeviceTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceToken($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDeviceToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceToken() => clearField(1);
}

class GetBannerAlertsRequest extends $pb.GeneratedMessage {
  factory GetBannerAlertsRequest() => create();
  GetBannerAlertsRequest._() : super();
  factory GetBannerAlertsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetBannerAlertsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBannerAlertsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetBannerAlertsRequest clone() =>
      GetBannerAlertsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetBannerAlertsRequest copyWith(
          void Function(GetBannerAlertsRequest) updates) =>
      super.copyWith((message) => updates(message as GetBannerAlertsRequest))
          as GetBannerAlertsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBannerAlertsRequest create() => GetBannerAlertsRequest._();
  GetBannerAlertsRequest createEmptyInstance() => create();
  static $pb.PbList<GetBannerAlertsRequest> createRepeated() =>
      $pb.PbList<GetBannerAlertsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBannerAlertsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBannerAlertsRequest>(create);
  static GetBannerAlertsRequest? _defaultInstance;
}

class GetFeatureNotificationsRequest extends $pb.GeneratedMessage {
  factory GetFeatureNotificationsRequest() => create();
  GetFeatureNotificationsRequest._() : super();
  factory GetFeatureNotificationsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetFeatureNotificationsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeatureNotificationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFeatureNotificationsRequest clone() =>
      GetFeatureNotificationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFeatureNotificationsRequest copyWith(
          void Function(GetFeatureNotificationsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetFeatureNotificationsRequest))
          as GetFeatureNotificationsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeatureNotificationsRequest create() =>
      GetFeatureNotificationsRequest._();
  GetFeatureNotificationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFeatureNotificationsRequest> createRepeated() =>
      $pb.PbList<GetFeatureNotificationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFeatureNotificationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeatureNotificationsRequest>(create);
  static GetFeatureNotificationsRequest? _defaultInstance;
}

class PostDeviceTokenResponse extends $pb.GeneratedMessage {
  factory PostDeviceTokenResponse() => create();
  PostDeviceTokenResponse._() : super();
  factory PostDeviceTokenResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PostDeviceTokenResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PostDeviceTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PostDeviceTokenResponse clone() =>
      PostDeviceTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PostDeviceTokenResponse copyWith(
          void Function(PostDeviceTokenResponse) updates) =>
      super.copyWith((message) => updates(message as PostDeviceTokenResponse))
          as PostDeviceTokenResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PostDeviceTokenResponse create() => PostDeviceTokenResponse._();
  PostDeviceTokenResponse createEmptyInstance() => create();
  static $pb.PbList<PostDeviceTokenResponse> createRepeated() =>
      $pb.PbList<PostDeviceTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static PostDeviceTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PostDeviceTokenResponse>(create);
  static PostDeviceTokenResponse? _defaultInstance;
}

class DeleteDeviceTokenResponse extends $pb.GeneratedMessage {
  factory DeleteDeviceTokenResponse() => create();
  DeleteDeviceTokenResponse._() : super();
  factory DeleteDeviceTokenResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteDeviceTokenResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteDeviceTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteDeviceTokenResponse clone() =>
      DeleteDeviceTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteDeviceTokenResponse copyWith(
          void Function(DeleteDeviceTokenResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteDeviceTokenResponse))
          as DeleteDeviceTokenResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteDeviceTokenResponse create() => DeleteDeviceTokenResponse._();
  DeleteDeviceTokenResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteDeviceTokenResponse> createRepeated() =>
      $pb.PbList<DeleteDeviceTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteDeviceTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteDeviceTokenResponse>(create);
  static DeleteDeviceTokenResponse? _defaultInstance;
}

class GetBannerAlertsResponse extends $pb.GeneratedMessage {
  factory GetBannerAlertsResponse({
    $core.Iterable<BannerAlert>? bannerAlerts,
  }) {
    final $result = create();
    if (bannerAlerts != null) {
      $result.bannerAlerts.addAll(bannerAlerts);
    }
    return $result;
  }
  GetBannerAlertsResponse._() : super();
  factory GetBannerAlertsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetBannerAlertsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBannerAlertsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<BannerAlert>(
        1, _omitFieldNames ? '' : 'bannerAlerts', $pb.PbFieldType.PM,
        protoName: 'bannerAlerts', subBuilder: BannerAlert.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetBannerAlertsResponse clone() =>
      GetBannerAlertsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetBannerAlertsResponse copyWith(
          void Function(GetBannerAlertsResponse) updates) =>
      super.copyWith((message) => updates(message as GetBannerAlertsResponse))
          as GetBannerAlertsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBannerAlertsResponse create() => GetBannerAlertsResponse._();
  GetBannerAlertsResponse createEmptyInstance() => create();
  static $pb.PbList<GetBannerAlertsResponse> createRepeated() =>
      $pb.PbList<GetBannerAlertsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBannerAlertsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBannerAlertsResponse>(create);
  static GetBannerAlertsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BannerAlert> get bannerAlerts => $_getList(0);
}

class GetFeatureNotificationsResponse extends $pb.GeneratedMessage {
  factory GetFeatureNotificationsResponse({
    $core.Iterable<FeatureNotification>? featureNotifications,
  }) {
    final $result = create();
    if (featureNotifications != null) {
      $result.featureNotifications.addAll(featureNotifications);
    }
    return $result;
  }
  GetFeatureNotificationsResponse._() : super();
  factory GetFeatureNotificationsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetFeatureNotificationsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeatureNotificationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<FeatureNotification>(
        1, _omitFieldNames ? '' : 'featureNotifications', $pb.PbFieldType.PM,
        protoName: 'featureNotifications',
        subBuilder: FeatureNotification.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFeatureNotificationsResponse clone() =>
      GetFeatureNotificationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFeatureNotificationsResponse copyWith(
          void Function(GetFeatureNotificationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetFeatureNotificationsResponse))
          as GetFeatureNotificationsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeatureNotificationsResponse create() =>
      GetFeatureNotificationsResponse._();
  GetFeatureNotificationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFeatureNotificationsResponse> createRepeated() =>
      $pb.PbList<GetFeatureNotificationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFeatureNotificationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeatureNotificationsResponse>(
          create);
  static GetFeatureNotificationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FeatureNotification> get featureNotifications => $_getList(0);
}

class Course extends $pb.GeneratedMessage {
  factory Course({
    $core.int? id,
    $core.String? name,
    $core.String? slug,
    Semester? semester,
    $core.String? tUMOnlineIdentifier,
    $core.bool? vODEnabled,
    $core.bool? downloadsEnabled,
    $core.bool? chatEnabled,
    $core.bool? anonymousChatEnabled,
    $core.bool? moderatedChatEnabled,
    $core.bool? vodChatEnabled,
    $core.Iterable<Stream>? streams,
    $core.String? cameraPresetPreferences,
    $core.String? sourcePreferences,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (slug != null) {
      $result.slug = slug;
    }
    if (semester != null) {
      $result.semester = semester;
    }
    if (tUMOnlineIdentifier != null) {
      $result.tUMOnlineIdentifier = tUMOnlineIdentifier;
    }
    if (vODEnabled != null) {
      $result.vODEnabled = vODEnabled;
    }
    if (downloadsEnabled != null) {
      $result.downloadsEnabled = downloadsEnabled;
    }
    if (chatEnabled != null) {
      $result.chatEnabled = chatEnabled;
    }
    if (anonymousChatEnabled != null) {
      $result.anonymousChatEnabled = anonymousChatEnabled;
    }
    if (moderatedChatEnabled != null) {
      $result.moderatedChatEnabled = moderatedChatEnabled;
    }
    if (vodChatEnabled != null) {
      $result.vodChatEnabled = vodChatEnabled;
    }
    if (streams != null) {
      $result.streams.addAll(streams);
    }
    if (cameraPresetPreferences != null) {
      $result.cameraPresetPreferences = cameraPresetPreferences;
    }
    if (sourcePreferences != null) {
      $result.sourcePreferences = sourcePreferences;
    }
    return $result;
  }
  Course._() : super();
  factory Course.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Course.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Course',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'slug')
    ..aOM<Semester>(4, _omitFieldNames ? '' : 'semester',
        subBuilder: Semester.create)
    ..aOS(5, _omitFieldNames ? '' : 'TUMOnlineIdentifier',
        protoName: 'TUMOnlineIdentifier')
    ..aOB(6, _omitFieldNames ? '' : 'VODEnabled', protoName: 'VODEnabled')
    ..aOB(7, _omitFieldNames ? '' : 'downloadsEnabled',
        protoName: 'downloadsEnabled')
    ..aOB(8, _omitFieldNames ? '' : 'chatEnabled', protoName: 'chatEnabled')
    ..aOB(9, _omitFieldNames ? '' : 'anonymousChatEnabled',
        protoName: 'anonymousChatEnabled')
    ..aOB(10, _omitFieldNames ? '' : 'moderatedChatEnabled',
        protoName: 'moderatedChatEnabled')
    ..aOB(11, _omitFieldNames ? '' : 'vodChatEnabled',
        protoName: 'vodChatEnabled')
    ..pc<Stream>(12, _omitFieldNames ? '' : 'streams', $pb.PbFieldType.PM,
        subBuilder: Stream.create)
    ..aOS(13, _omitFieldNames ? '' : 'cameraPresetPreferences',
        protoName: 'cameraPresetPreferences')
    ..aOS(14, _omitFieldNames ? '' : 'sourcePreferences',
        protoName: 'sourcePreferences')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Course clone() => Course()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Course copyWith(void Function(Course) updates) =>
      super.copyWith((message) => updates(message as Course)) as Course;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Course create() => Course._();
  Course createEmptyInstance() => create();
  static $pb.PbList<Course> createRepeated() => $pb.PbList<Course>();
  @$core.pragma('dart2js:noInline')
  static Course getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Course>(create);
  static Course? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get slug => $_getSZ(2);
  @$pb.TagNumber(3)
  set slug($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearSlug() => clearField(3);

  @$pb.TagNumber(4)
  Semester get semester => $_getN(3);
  @$pb.TagNumber(4)
  set semester(Semester v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSemester() => $_has(3);
  @$pb.TagNumber(4)
  void clearSemester() => clearField(4);
  @$pb.TagNumber(4)
  Semester ensureSemester() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get tUMOnlineIdentifier => $_getSZ(4);
  @$pb.TagNumber(5)
  set tUMOnlineIdentifier($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTUMOnlineIdentifier() => $_has(4);
  @$pb.TagNumber(5)
  void clearTUMOnlineIdentifier() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get vODEnabled => $_getBF(5);
  @$pb.TagNumber(6)
  set vODEnabled($core.bool v) {
    $_setBool(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasVODEnabled() => $_has(5);
  @$pb.TagNumber(6)
  void clearVODEnabled() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get downloadsEnabled => $_getBF(6);
  @$pb.TagNumber(7)
  set downloadsEnabled($core.bool v) {
    $_setBool(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasDownloadsEnabled() => $_has(6);
  @$pb.TagNumber(7)
  void clearDownloadsEnabled() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get chatEnabled => $_getBF(7);
  @$pb.TagNumber(8)
  set chatEnabled($core.bool v) {
    $_setBool(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasChatEnabled() => $_has(7);
  @$pb.TagNumber(8)
  void clearChatEnabled() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get anonymousChatEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set anonymousChatEnabled($core.bool v) {
    $_setBool(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasAnonymousChatEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearAnonymousChatEnabled() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get moderatedChatEnabled => $_getBF(9);
  @$pb.TagNumber(10)
  set moderatedChatEnabled($core.bool v) {
    $_setBool(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasModeratedChatEnabled() => $_has(9);
  @$pb.TagNumber(10)
  void clearModeratedChatEnabled() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get vodChatEnabled => $_getBF(10);
  @$pb.TagNumber(11)
  set vodChatEnabled($core.bool v) {
    $_setBool(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasVodChatEnabled() => $_has(10);
  @$pb.TagNumber(11)
  void clearVodChatEnabled() => clearField(11);

  @$pb.TagNumber(12)
  $core.List<Stream> get streams => $_getList(11);

  @$pb.TagNumber(13)
  $core.String get cameraPresetPreferences => $_getSZ(12);
  @$pb.TagNumber(13)
  set cameraPresetPreferences($core.String v) {
    $_setString(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasCameraPresetPreferences() => $_has(12);
  @$pb.TagNumber(13)
  void clearCameraPresetPreferences() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get sourcePreferences => $_getSZ(13);
  @$pb.TagNumber(14)
  set sourcePreferences($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasSourcePreferences() => $_has(13);
  @$pb.TagNumber(14)
  void clearSourcePreferences() => clearField(14);
}

class Semester extends $pb.GeneratedMessage {
  factory Semester({
    $core.String? teachingTerm,
    $core.int? year,
  }) {
    final $result = create();
    if (teachingTerm != null) {
      $result.teachingTerm = teachingTerm;
    }
    if (year != null) {
      $result.year = year;
    }
    return $result;
  }
  Semester._() : super();
  factory Semester.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Semester.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Semester',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'teachingTerm', protoName: 'teachingTerm')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'year', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Semester clone() => Semester()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Semester copyWith(void Function(Semester) updates) =>
      super.copyWith((message) => updates(message as Semester)) as Semester;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Semester create() => Semester._();
  Semester createEmptyInstance() => create();
  static $pb.PbList<Semester> createRepeated() => $pb.PbList<Semester>();
  @$core.pragma('dart2js:noInline')
  static Semester getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Semester>(create);
  static Semester? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get teachingTerm => $_getSZ(0);
  @$pb.TagNumber(1)
  set teachingTerm($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTeachingTerm() => $_has(0);
  @$pb.TagNumber(1)
  void clearTeachingTerm() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get year => $_getIZ(1);
  @$pb.TagNumber(2)
  set year($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasYear() => $_has(1);
  @$pb.TagNumber(2)
  void clearYear() => clearField(2);
}

class GetPublicCoursesRequest extends $pb.GeneratedMessage {
  factory GetPublicCoursesRequest({
    $core.int? year,
    $core.String? term,
    $core.int? limit,
    $core.int? skip,
  }) {
    final $result = create();
    if (year != null) {
      $result.year = year;
    }
    if (term != null) {
      $result.term = term;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (skip != null) {
      $result.skip = skip;
    }
    return $result;
  }
  GetPublicCoursesRequest._() : super();
  factory GetPublicCoursesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetPublicCoursesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPublicCoursesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'year', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'term')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'skip', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetPublicCoursesRequest clone() =>
      GetPublicCoursesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetPublicCoursesRequest copyWith(
          void Function(GetPublicCoursesRequest) updates) =>
      super.copyWith((message) => updates(message as GetPublicCoursesRequest))
          as GetPublicCoursesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPublicCoursesRequest create() => GetPublicCoursesRequest._();
  GetPublicCoursesRequest createEmptyInstance() => create();
  static $pb.PbList<GetPublicCoursesRequest> createRepeated() =>
      $pb.PbList<GetPublicCoursesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPublicCoursesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPublicCoursesRequest>(create);
  static GetPublicCoursesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get year => $_getIZ(0);
  @$pb.TagNumber(1)
  set year($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasYear() => $_has(0);
  @$pb.TagNumber(1)
  void clearYear() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get term => $_getSZ(1);
  @$pb.TagNumber(2)
  set term($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTerm() => $_has(1);
  @$pb.TagNumber(2)
  void clearTerm() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get skip => $_getIZ(3);
  @$pb.TagNumber(4)
  set skip($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSkip() => $_has(3);
  @$pb.TagNumber(4)
  void clearSkip() => clearField(4);
}

class GetSemestersRequest extends $pb.GeneratedMessage {
  factory GetSemestersRequest() => create();
  GetSemestersRequest._() : super();
  factory GetSemestersRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetSemestersRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSemestersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetSemestersRequest clone() => GetSemestersRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetSemestersRequest copyWith(void Function(GetSemestersRequest) updates) =>
      super.copyWith((message) => updates(message as GetSemestersRequest))
          as GetSemestersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSemestersRequest create() => GetSemestersRequest._();
  GetSemestersRequest createEmptyInstance() => create();
  static $pb.PbList<GetSemestersRequest> createRepeated() =>
      $pb.PbList<GetSemestersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSemestersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSemestersRequest>(create);
  static GetSemestersRequest? _defaultInstance;
}

class GetCourseStreamsRequest extends $pb.GeneratedMessage {
  factory GetCourseStreamsRequest({
    $core.int? courseID,
  }) {
    final $result = create();
    if (courseID != null) {
      $result.courseID = courseID;
    }
    return $result;
  }
  GetCourseStreamsRequest._() : super();
  factory GetCourseStreamsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetCourseStreamsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCourseStreamsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'courseID', $pb.PbFieldType.O3,
        protoName: 'courseID')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetCourseStreamsRequest clone() =>
      GetCourseStreamsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetCourseStreamsRequest copyWith(
          void Function(GetCourseStreamsRequest) updates) =>
      super.copyWith((message) => updates(message as GetCourseStreamsRequest))
          as GetCourseStreamsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCourseStreamsRequest create() => GetCourseStreamsRequest._();
  GetCourseStreamsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCourseStreamsRequest> createRepeated() =>
      $pb.PbList<GetCourseStreamsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCourseStreamsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCourseStreamsRequest>(create);
  static GetCourseStreamsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get courseID => $_getIZ(0);
  @$pb.TagNumber(1)
  set courseID($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCourseID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCourseID() => clearField(1);
}

class GetPublicCoursesResponse extends $pb.GeneratedMessage {
  factory GetPublicCoursesResponse({
    $core.Iterable<Course>? courses,
  }) {
    final $result = create();
    if (courses != null) {
      $result.courses.addAll(courses);
    }
    return $result;
  }
  GetPublicCoursesResponse._() : super();
  factory GetPublicCoursesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetPublicCoursesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPublicCoursesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<Course>(1, _omitFieldNames ? '' : 'courses', $pb.PbFieldType.PM,
        subBuilder: Course.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetPublicCoursesResponse clone() =>
      GetPublicCoursesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetPublicCoursesResponse copyWith(
          void Function(GetPublicCoursesResponse) updates) =>
      super.copyWith((message) => updates(message as GetPublicCoursesResponse))
          as GetPublicCoursesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPublicCoursesResponse create() => GetPublicCoursesResponse._();
  GetPublicCoursesResponse createEmptyInstance() => create();
  static $pb.PbList<GetPublicCoursesResponse> createRepeated() =>
      $pb.PbList<GetPublicCoursesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPublicCoursesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPublicCoursesResponse>(create);
  static GetPublicCoursesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Course> get courses => $_getList(0);
}

class GetSemestersResponse extends $pb.GeneratedMessage {
  factory GetSemestersResponse({
    Semester? current,
    $core.Iterable<Semester>? semesters,
  }) {
    final $result = create();
    if (current != null) {
      $result.current = current;
    }
    if (semesters != null) {
      $result.semesters.addAll(semesters);
    }
    return $result;
  }
  GetSemestersResponse._() : super();
  factory GetSemestersResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetSemestersResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSemestersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOM<Semester>(1, _omitFieldNames ? '' : 'current',
        subBuilder: Semester.create)
    ..pc<Semester>(2, _omitFieldNames ? '' : 'semesters', $pb.PbFieldType.PM,
        subBuilder: Semester.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetSemestersResponse clone() =>
      GetSemestersResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetSemestersResponse copyWith(void Function(GetSemestersResponse) updates) =>
      super.copyWith((message) => updates(message as GetSemestersResponse))
          as GetSemestersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSemestersResponse create() => GetSemestersResponse._();
  GetSemestersResponse createEmptyInstance() => create();
  static $pb.PbList<GetSemestersResponse> createRepeated() =>
      $pb.PbList<GetSemestersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSemestersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSemestersResponse>(create);
  static GetSemestersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Semester get current => $_getN(0);
  @$pb.TagNumber(1)
  set current(Semester v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCurrent() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrent() => clearField(1);
  @$pb.TagNumber(1)
  Semester ensureCurrent() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<Semester> get semesters => $_getList(1);
}

class GetCourseStreamsResponse extends $pb.GeneratedMessage {
  factory GetCourseStreamsResponse({
    $core.Iterable<Stream>? streams,
  }) {
    final $result = create();
    if (streams != null) {
      $result.streams.addAll(streams);
    }
    return $result;
  }
  GetCourseStreamsResponse._() : super();
  factory GetCourseStreamsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetCourseStreamsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCourseStreamsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<Stream>(1, _omitFieldNames ? '' : 'streams', $pb.PbFieldType.PM,
        subBuilder: Stream.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetCourseStreamsResponse clone() =>
      GetCourseStreamsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetCourseStreamsResponse copyWith(
          void Function(GetCourseStreamsResponse) updates) =>
      super.copyWith((message) => updates(message as GetCourseStreamsResponse))
          as GetCourseStreamsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCourseStreamsResponse create() => GetCourseStreamsResponse._();
  GetCourseStreamsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCourseStreamsResponse> createRepeated() =>
      $pb.PbList<GetCourseStreamsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCourseStreamsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCourseStreamsResponse>(create);
  static GetCourseStreamsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Stream> get streams => $_getList(0);
}

class Stream extends $pb.GeneratedMessage {
  factory Stream({
    $fixnum.Int64? id,
    $core.String? name,
    $core.String? description,
    $core.int? courseID,
    $1.Timestamp? start,
    $1.Timestamp? end,
    $core.bool? chatEnabled,
    $core.String? roomName,
    $core.String? roomCode,
    $core.String? eventTypeName,
    $core.int? tUMOnlineEventID,
    $core.String? seriesIdentifier,
    $core.String? playlistUrl,
    $core.String? playlistUrlPRES,
    $core.String? playlistUrlCAM,
    $core.bool? liveNow,
    $1.Timestamp? liveNowTimestamp,
    $core.bool? recording,
    $core.bool? premiere,
    $core.bool? ended,
    $core.int? vodViews,
    $core.int? startOffset,
    $core.int? endOffset,
    $core.int? duration,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    if (courseID != null) {
      $result.courseID = courseID;
    }
    if (start != null) {
      $result.start = start;
    }
    if (end != null) {
      $result.end = end;
    }
    if (chatEnabled != null) {
      $result.chatEnabled = chatEnabled;
    }
    if (roomName != null) {
      $result.roomName = roomName;
    }
    if (roomCode != null) {
      $result.roomCode = roomCode;
    }
    if (eventTypeName != null) {
      $result.eventTypeName = eventTypeName;
    }
    if (tUMOnlineEventID != null) {
      $result.tUMOnlineEventID = tUMOnlineEventID;
    }
    if (seriesIdentifier != null) {
      $result.seriesIdentifier = seriesIdentifier;
    }
    if (playlistUrl != null) {
      $result.playlistUrl = playlistUrl;
    }
    if (playlistUrlPRES != null) {
      $result.playlistUrlPRES = playlistUrlPRES;
    }
    if (playlistUrlCAM != null) {
      $result.playlistUrlCAM = playlistUrlCAM;
    }
    if (liveNow != null) {
      $result.liveNow = liveNow;
    }
    if (liveNowTimestamp != null) {
      $result.liveNowTimestamp = liveNowTimestamp;
    }
    if (recording != null) {
      $result.recording = recording;
    }
    if (premiere != null) {
      $result.premiere = premiere;
    }
    if (ended != null) {
      $result.ended = ended;
    }
    if (vodViews != null) {
      $result.vodViews = vodViews;
    }
    if (startOffset != null) {
      $result.startOffset = startOffset;
    }
    if (endOffset != null) {
      $result.endOffset = endOffset;
    }
    if (duration != null) {
      $result.duration = duration;
    }
    return $result;
  }
  Stream._() : super();
  factory Stream.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Stream.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Stream',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'courseID', $pb.PbFieldType.OU3,
        protoName: 'courseID')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'start',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'end',
        subBuilder: $1.Timestamp.create)
    ..aOB(7, _omitFieldNames ? '' : 'chatEnabled', protoName: 'chatEnabled')
    ..aOS(8, _omitFieldNames ? '' : 'roomName', protoName: 'roomName')
    ..aOS(9, _omitFieldNames ? '' : 'roomCode', protoName: 'roomCode')
    ..aOS(10, _omitFieldNames ? '' : 'eventTypeName',
        protoName: 'eventTypeName')
    ..a<$core.int>(
        11, _omitFieldNames ? '' : 'TUMOnlineEventID', $pb.PbFieldType.OU3,
        protoName: 'TUMOnlineEventID')
    ..aOS(12, _omitFieldNames ? '' : 'seriesIdentifier',
        protoName: 'seriesIdentifier')
    ..aOS(13, _omitFieldNames ? '' : 'playlistUrl', protoName: 'playlistUrl')
    ..aOS(14, _omitFieldNames ? '' : 'playlistUrlPRES',
        protoName: 'playlistUrlPRES')
    ..aOS(15, _omitFieldNames ? '' : 'playlistUrlCAM',
        protoName: 'playlistUrlCAM')
    ..aOB(16, _omitFieldNames ? '' : 'liveNow', protoName: 'liveNow')
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'liveNowTimestamp',
        protoName: 'liveNowTimestamp', subBuilder: $1.Timestamp.create)
    ..aOB(18, _omitFieldNames ? '' : 'recording')
    ..aOB(19, _omitFieldNames ? '' : 'premiere')
    ..aOB(20, _omitFieldNames ? '' : 'ended')
    ..a<$core.int>(21, _omitFieldNames ? '' : 'vodViews', $pb.PbFieldType.OU3,
        protoName: 'vodViews')
    ..a<$core.int>(
        22, _omitFieldNames ? '' : 'startOffset', $pb.PbFieldType.OU3,
        protoName: 'startOffset')
    ..a<$core.int>(23, _omitFieldNames ? '' : 'endOffset', $pb.PbFieldType.OU3,
        protoName: 'endOffset')
    ..a<$core.int>(28, _omitFieldNames ? '' : 'duration', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Stream clone() => Stream()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Stream copyWith(void Function(Stream) updates) =>
      super.copyWith((message) => updates(message as Stream)) as Stream;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Stream create() => Stream._();
  Stream createEmptyInstance() => create();
  static $pb.PbList<Stream> createRepeated() => $pb.PbList<Stream>();
  @$core.pragma('dart2js:noInline')
  static Stream getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Stream>(create);
  static Stream? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get courseID => $_getIZ(3);
  @$pb.TagNumber(4)
  set courseID($core.int v) {
    $_setUnsignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCourseID() => $_has(3);
  @$pb.TagNumber(4)
  void clearCourseID() => clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get start => $_getN(4);
  @$pb.TagNumber(5)
  set start($1.Timestamp v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasStart() => $_has(4);
  @$pb.TagNumber(5)
  void clearStart() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureStart() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Timestamp get end => $_getN(5);
  @$pb.TagNumber(6)
  set end($1.Timestamp v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasEnd() => $_has(5);
  @$pb.TagNumber(6)
  void clearEnd() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureEnd() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get chatEnabled => $_getBF(6);
  @$pb.TagNumber(7)
  set chatEnabled($core.bool v) {
    $_setBool(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasChatEnabled() => $_has(6);
  @$pb.TagNumber(7)
  void clearChatEnabled() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get roomName => $_getSZ(7);
  @$pb.TagNumber(8)
  set roomName($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasRoomName() => $_has(7);
  @$pb.TagNumber(8)
  void clearRoomName() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get roomCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set roomCode($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasRoomCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearRoomCode() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get eventTypeName => $_getSZ(9);
  @$pb.TagNumber(10)
  set eventTypeName($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasEventTypeName() => $_has(9);
  @$pb.TagNumber(10)
  void clearEventTypeName() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get tUMOnlineEventID => $_getIZ(10);
  @$pb.TagNumber(11)
  set tUMOnlineEventID($core.int v) {
    $_setUnsignedInt32(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasTUMOnlineEventID() => $_has(10);
  @$pb.TagNumber(11)
  void clearTUMOnlineEventID() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get seriesIdentifier => $_getSZ(11);
  @$pb.TagNumber(12)
  set seriesIdentifier($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasSeriesIdentifier() => $_has(11);
  @$pb.TagNumber(12)
  void clearSeriesIdentifier() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get playlistUrl => $_getSZ(12);
  @$pb.TagNumber(13)
  set playlistUrl($core.String v) {
    $_setString(12, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasPlaylistUrl() => $_has(12);
  @$pb.TagNumber(13)
  void clearPlaylistUrl() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get playlistUrlPRES => $_getSZ(13);
  @$pb.TagNumber(14)
  set playlistUrlPRES($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasPlaylistUrlPRES() => $_has(13);
  @$pb.TagNumber(14)
  void clearPlaylistUrlPRES() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get playlistUrlCAM => $_getSZ(14);
  @$pb.TagNumber(15)
  set playlistUrlCAM($core.String v) {
    $_setString(14, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasPlaylistUrlCAM() => $_has(14);
  @$pb.TagNumber(15)
  void clearPlaylistUrlCAM() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get liveNow => $_getBF(15);
  @$pb.TagNumber(16)
  set liveNow($core.bool v) {
    $_setBool(15, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasLiveNow() => $_has(15);
  @$pb.TagNumber(16)
  void clearLiveNow() => clearField(16);

  @$pb.TagNumber(17)
  $1.Timestamp get liveNowTimestamp => $_getN(16);
  @$pb.TagNumber(17)
  set liveNowTimestamp($1.Timestamp v) {
    setField(17, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasLiveNowTimestamp() => $_has(16);
  @$pb.TagNumber(17)
  void clearLiveNowTimestamp() => clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureLiveNowTimestamp() => $_ensure(16);

  @$pb.TagNumber(18)
  $core.bool get recording => $_getBF(17);
  @$pb.TagNumber(18)
  set recording($core.bool v) {
    $_setBool(17, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasRecording() => $_has(17);
  @$pb.TagNumber(18)
  void clearRecording() => clearField(18);

  @$pb.TagNumber(19)
  $core.bool get premiere => $_getBF(18);
  @$pb.TagNumber(19)
  set premiere($core.bool v) {
    $_setBool(18, v);
  }

  @$pb.TagNumber(19)
  $core.bool hasPremiere() => $_has(18);
  @$pb.TagNumber(19)
  void clearPremiere() => clearField(19);

  @$pb.TagNumber(20)
  $core.bool get ended => $_getBF(19);
  @$pb.TagNumber(20)
  set ended($core.bool v) {
    $_setBool(19, v);
  }

  @$pb.TagNumber(20)
  $core.bool hasEnded() => $_has(19);
  @$pb.TagNumber(20)
  void clearEnded() => clearField(20);

  @$pb.TagNumber(21)
  $core.int get vodViews => $_getIZ(20);
  @$pb.TagNumber(21)
  set vodViews($core.int v) {
    $_setUnsignedInt32(20, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasVodViews() => $_has(20);
  @$pb.TagNumber(21)
  void clearVodViews() => clearField(21);

  @$pb.TagNumber(22)
  $core.int get startOffset => $_getIZ(21);
  @$pb.TagNumber(22)
  set startOffset($core.int v) {
    $_setUnsignedInt32(21, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasStartOffset() => $_has(21);
  @$pb.TagNumber(22)
  void clearStartOffset() => clearField(22);

  @$pb.TagNumber(23)
  $core.int get endOffset => $_getIZ(22);
  @$pb.TagNumber(23)
  set endOffset($core.int v) {
    $_setUnsignedInt32(22, v);
  }

  @$pb.TagNumber(23)
  $core.bool hasEndOffset() => $_has(22);
  @$pb.TagNumber(23)
  void clearEndOffset() => clearField(23);

  @$pb.TagNumber(28)
  $core.int get duration => $_getIZ(23);
  @$pb.TagNumber(28)
  set duration($core.int v) {
    $_setSignedInt32(23, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasDuration() => $_has(23);
  @$pb.TagNumber(28)
  void clearDuration() => clearField(28);
}

class GetStreamRequest extends $pb.GeneratedMessage {
  factory GetStreamRequest({
    $fixnum.Int64? streamID,
  }) {
    final $result = create();
    if (streamID != null) {
      $result.streamID = streamID;
    }
    return $result;
  }
  GetStreamRequest._() : super();
  factory GetStreamRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetStreamRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStreamRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'streamID', $pb.PbFieldType.OU6,
        protoName: 'streamID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetStreamRequest clone() => GetStreamRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetStreamRequest copyWith(void Function(GetStreamRequest) updates) =>
      super.copyWith((message) => updates(message as GetStreamRequest))
          as GetStreamRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStreamRequest create() => GetStreamRequest._();
  GetStreamRequest createEmptyInstance() => create();
  static $pb.PbList<GetStreamRequest> createRepeated() =>
      $pb.PbList<GetStreamRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStreamRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStreamRequest>(create);
  static GetStreamRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get streamID => $_getI64(0);
  @$pb.TagNumber(1)
  set streamID($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStreamID() => $_has(0);
  @$pb.TagNumber(1)
  void clearStreamID() => clearField(1);
}

class GetNowLiveRequest extends $pb.GeneratedMessage {
  factory GetNowLiveRequest() => create();
  GetNowLiveRequest._() : super();
  factory GetNowLiveRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetNowLiveRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetNowLiveRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetNowLiveRequest clone() => GetNowLiveRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetNowLiveRequest copyWith(void Function(GetNowLiveRequest) updates) =>
      super.copyWith((message) => updates(message as GetNowLiveRequest))
          as GetNowLiveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNowLiveRequest create() => GetNowLiveRequest._();
  GetNowLiveRequest createEmptyInstance() => create();
  static $pb.PbList<GetNowLiveRequest> createRepeated() =>
      $pb.PbList<GetNowLiveRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNowLiveRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetNowLiveRequest>(create);
  static GetNowLiveRequest? _defaultInstance;
}

class GetThumbsLiveRequest extends $pb.GeneratedMessage {
  factory GetThumbsLiveRequest({
    $fixnum.Int64? streamID,
  }) {
    final $result = create();
    if (streamID != null) {
      $result.streamID = streamID;
    }
    return $result;
  }
  GetThumbsLiveRequest._() : super();
  factory GetThumbsLiveRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetThumbsLiveRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetThumbsLiveRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'streamID', $pb.PbFieldType.OU6,
        protoName: 'streamID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetThumbsLiveRequest clone() =>
      GetThumbsLiveRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetThumbsLiveRequest copyWith(void Function(GetThumbsLiveRequest) updates) =>
      super.copyWith((message) => updates(message as GetThumbsLiveRequest))
          as GetThumbsLiveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetThumbsLiveRequest create() => GetThumbsLiveRequest._();
  GetThumbsLiveRequest createEmptyInstance() => create();
  static $pb.PbList<GetThumbsLiveRequest> createRepeated() =>
      $pb.PbList<GetThumbsLiveRequest>();
  @$core.pragma('dart2js:noInline')
  static GetThumbsLiveRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetThumbsLiveRequest>(create);
  static GetThumbsLiveRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get streamID => $_getI64(0);
  @$pb.TagNumber(1)
  set streamID($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStreamID() => $_has(0);
  @$pb.TagNumber(1)
  void clearStreamID() => clearField(1);
}

class GetThumbsVODRequest extends $pb.GeneratedMessage {
  factory GetThumbsVODRequest({
    $fixnum.Int64? streamID,
  }) {
    final $result = create();
    if (streamID != null) {
      $result.streamID = streamID;
    }
    return $result;
  }
  GetThumbsVODRequest._() : super();
  factory GetThumbsVODRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetThumbsVODRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetThumbsVODRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'streamID', $pb.PbFieldType.OU6,
        protoName: 'streamID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetThumbsVODRequest clone() => GetThumbsVODRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetThumbsVODRequest copyWith(void Function(GetThumbsVODRequest) updates) =>
      super.copyWith((message) => updates(message as GetThumbsVODRequest))
          as GetThumbsVODRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetThumbsVODRequest create() => GetThumbsVODRequest._();
  GetThumbsVODRequest createEmptyInstance() => create();
  static $pb.PbList<GetThumbsVODRequest> createRepeated() =>
      $pb.PbList<GetThumbsVODRequest>();
  @$core.pragma('dart2js:noInline')
  static GetThumbsVODRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetThumbsVODRequest>(create);
  static GetThumbsVODRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get streamID => $_getI64(0);
  @$pb.TagNumber(1)
  set streamID($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStreamID() => $_has(0);
  @$pb.TagNumber(1)
  void clearStreamID() => clearField(1);
}

class GetStreamResponse extends $pb.GeneratedMessage {
  factory GetStreamResponse({
    Stream? stream,
  }) {
    final $result = create();
    if (stream != null) {
      $result.stream = stream;
    }
    return $result;
  }
  GetStreamResponse._() : super();
  factory GetStreamResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetStreamResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStreamResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOM<Stream>(1, _omitFieldNames ? '' : 'stream', subBuilder: Stream.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetStreamResponse clone() => GetStreamResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetStreamResponse copyWith(void Function(GetStreamResponse) updates) =>
      super.copyWith((message) => updates(message as GetStreamResponse))
          as GetStreamResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStreamResponse create() => GetStreamResponse._();
  GetStreamResponse createEmptyInstance() => create();
  static $pb.PbList<GetStreamResponse> createRepeated() =>
      $pb.PbList<GetStreamResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStreamResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStreamResponse>(create);
  static GetStreamResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Stream get stream => $_getN(0);
  @$pb.TagNumber(1)
  set stream(Stream v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStream() => $_has(0);
  @$pb.TagNumber(1)
  void clearStream() => clearField(1);
  @$pb.TagNumber(1)
  Stream ensureStream() => $_ensure(0);
}

class GetNowLiveResponse extends $pb.GeneratedMessage {
  factory GetNowLiveResponse({
    $core.Iterable<Stream>? stream,
  }) {
    final $result = create();
    if (stream != null) {
      $result.stream.addAll(stream);
    }
    return $result;
  }
  GetNowLiveResponse._() : super();
  factory GetNowLiveResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetNowLiveResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetNowLiveResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..pc<Stream>(1, _omitFieldNames ? '' : 'stream', $pb.PbFieldType.PM,
        subBuilder: Stream.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetNowLiveResponse clone() => GetNowLiveResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetNowLiveResponse copyWith(void Function(GetNowLiveResponse) updates) =>
      super.copyWith((message) => updates(message as GetNowLiveResponse))
          as GetNowLiveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNowLiveResponse create() => GetNowLiveResponse._();
  GetNowLiveResponse createEmptyInstance() => create();
  static $pb.PbList<GetNowLiveResponse> createRepeated() =>
      $pb.PbList<GetNowLiveResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNowLiveResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetNowLiveResponse>(create);
  static GetNowLiveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Stream> get stream => $_getList(0);
}

class GetThumbsVODResponse extends $pb.GeneratedMessage {
  factory GetThumbsVODResponse({
    $core.String? path,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  GetThumbsVODResponse._() : super();
  factory GetThumbsVODResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetThumbsVODResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetThumbsVODResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetThumbsVODResponse clone() =>
      GetThumbsVODResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetThumbsVODResponse copyWith(void Function(GetThumbsVODResponse) updates) =>
      super.copyWith((message) => updates(message as GetThumbsVODResponse))
          as GetThumbsVODResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetThumbsVODResponse create() => GetThumbsVODResponse._();
  GetThumbsVODResponse createEmptyInstance() => create();
  static $pb.PbList<GetThumbsVODResponse> createRepeated() =>
      $pb.PbList<GetThumbsVODResponse>();
  @$core.pragma('dart2js:noInline')
  static GetThumbsVODResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetThumbsVODResponse>(create);
  static GetThumbsVODResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

class GetThumbsLiveResponse extends $pb.GeneratedMessage {
  factory GetThumbsLiveResponse({
    $core.String? path,
  }) {
    final $result = create();
    if (path != null) {
      $result.path = path;
    }
    return $result;
  }
  GetThumbsLiveResponse._() : super();
  factory GetThumbsLiveResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetThumbsLiveResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetThumbsLiveResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'path')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetThumbsLiveResponse clone() =>
      GetThumbsLiveResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetThumbsLiveResponse copyWith(
          void Function(GetThumbsLiveResponse) updates) =>
      super.copyWith((message) => updates(message as GetThumbsLiveResponse))
          as GetThumbsLiveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetThumbsLiveResponse create() => GetThumbsLiveResponse._();
  GetThumbsLiveResponse createEmptyInstance() => create();
  static $pb.PbList<GetThumbsLiveResponse> createRepeated() =>
      $pb.PbList<GetThumbsLiveResponse>();
  @$core.pragma('dart2js:noInline')
  static GetThumbsLiveResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetThumbsLiveResponse>(create);
  static GetThumbsLiveResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get path => $_getSZ(0);
  @$pb.TagNumber(1)
  set path($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearPath() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
