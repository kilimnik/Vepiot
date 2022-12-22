///
//  Generated code. Do not modify.
//  source: api/v1/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TOTPResponseType extends $pb.ProtobufEnum {
  static const TOTPResponseType TOTP_RESPONSE_TYPE_UNSPECIFIED = TOTPResponseType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOTP_RESPONSE_TYPE_UNSPECIFIED');
  static const TOTPResponseType TOTP_RESPONSE_TYPE_ALLOW = TOTPResponseType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOTP_RESPONSE_TYPE_ALLOW');
  static const TOTPResponseType TOTP_RESPONSE_TYPE_DENY = TOTPResponseType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOTP_RESPONSE_TYPE_DENY');

  static const $core.List<TOTPResponseType> values = <TOTPResponseType> [
    TOTP_RESPONSE_TYPE_UNSPECIFIED,
    TOTP_RESPONSE_TYPE_ALLOW,
    TOTP_RESPONSE_TYPE_DENY,
  ];

  static final $core.Map<$core.int, TOTPResponseType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TOTPResponseType? valueOf($core.int value) => _byValue[value];

  const TOTPResponseType._($core.int v, $core.String n) : super(v, n);
}

class TOTPRequestType extends $pb.ProtobufEnum {
  static const TOTPRequestType TOTP_REQUEST_TYPE_UNSPECIFIED = TOTPRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOTP_REQUEST_TYPE_UNSPECIFIED');
  static const TOTPRequestType TOTP_REQUEST_TYPE_REQUEST = TOTPRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOTP_REQUEST_TYPE_REQUEST');
  static const TOTPRequestType TOTP_REQUEST_TYPE_RESPONSE = TOTPRequestType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOTP_REQUEST_TYPE_RESPONSE');
  static const TOTPRequestType TOTP_REQUEST_TYPE_CANCEL = TOTPRequestType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TOTP_REQUEST_TYPE_CANCEL');

  static const $core.List<TOTPRequestType> values = <TOTPRequestType> [
    TOTP_REQUEST_TYPE_UNSPECIFIED,
    TOTP_REQUEST_TYPE_REQUEST,
    TOTP_REQUEST_TYPE_RESPONSE,
    TOTP_REQUEST_TYPE_CANCEL,
  ];

  static final $core.Map<$core.int, TOTPRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TOTPRequestType? valueOf($core.int value) => _byValue[value];

  const TOTPRequestType._($core.int v, $core.String n) : super(v, n);
}

