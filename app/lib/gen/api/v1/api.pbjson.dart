///
//  Generated code. Do not modify.
//  source: api/v1/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use tOTPResponseTypeDescriptor instead')
const TOTPResponseType$json = const {
  '1': 'TOTPResponseType',
  '2': const [
    const {'1': 'TOTP_RESPONSE_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'TOTP_RESPONSE_TYPE_ALLOW', '2': 1},
    const {'1': 'TOTP_RESPONSE_TYPE_DENY', '2': 2},
  ],
};

/// Descriptor for `TOTPResponseType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tOTPResponseTypeDescriptor = $convert.base64Decode('ChBUT1RQUmVzcG9uc2VUeXBlEiIKHlRPVFBfUkVTUE9OU0VfVFlQRV9VTlNQRUNJRklFRBAAEhwKGFRPVFBfUkVTUE9OU0VfVFlQRV9BTExPVxABEhsKF1RPVFBfUkVTUE9OU0VfVFlQRV9ERU5ZEAI=');
@$core.Deprecated('Use tOTPRequestTypeDescriptor instead')
const TOTPRequestType$json = const {
  '1': 'TOTPRequestType',
  '2': const [
    const {'1': 'TOTP_REQUEST_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'TOTP_REQUEST_TYPE_REQUEST', '2': 1},
    const {'1': 'TOTP_REQUEST_TYPE_RESPONSE', '2': 2},
    const {'1': 'TOTP_REQUEST_TYPE_CANCEL', '2': 3},
  ],
};

/// Descriptor for `TOTPRequestType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tOTPRequestTypeDescriptor = $convert.base64Decode('Cg9UT1RQUmVxdWVzdFR5cGUSIQodVE9UUF9SRVFVRVNUX1RZUEVfVU5TUEVDSUZJRUQQABIdChlUT1RQX1JFUVVFU1RfVFlQRV9SRVFVRVNUEAESHgoaVE9UUF9SRVFVRVNUX1RZUEVfUkVTUE9OU0UQAhIcChhUT1RQX1JFUVVFU1RfVFlQRV9DQU5DRUwQAw==');
@$core.Deprecated('Use tOTPResponseDescriptor instead')
const TOTPResponse$json = const {
  '1': 'TOTPResponse',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.api.v1.TOTPResponseType', '10': 'type'},
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'totp_code', '3': 3, '4': 1, '5': 9, '10': 'totpCode'},
    const {'1': 'device_id', '3': 4, '4': 1, '5': 9, '10': 'deviceId'},
    const {'1': 'name', '3': 5, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `TOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tOTPResponseDescriptor = $convert.base64Decode('CgxUT1RQUmVzcG9uc2USLAoEdHlwZRgBIAEoDjIYLmFwaS52MS5UT1RQUmVzcG9uc2VUeXBlUgR0eXBlEg4KAmlkGAIgASgJUgJpZBIbCgl0b3RwX2NvZGUYAyABKAlSCHRvdHBDb2RlEhsKCWRldmljZV9pZBgEIAEoCVIIZGV2aWNlSWQSEgoEbmFtZRgFIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use sendTOTPRequestDescriptor instead')
const SendTOTPRequest$json = const {
  '1': 'SendTOTPRequest',
  '2': const [
    const {'1': 'response', '3': 1, '4': 1, '5': 11, '6': '.api.v1.TOTPResponse', '10': 'response'},
  ],
};

/// Descriptor for `SendTOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendTOTPRequestDescriptor = $convert.base64Decode('Cg9TZW5kVE9UUFJlcXVlc3QSMAoIcmVzcG9uc2UYASABKAsyFC5hcGkudjEuVE9UUFJlc3BvbnNlUghyZXNwb25zZQ==');
@$core.Deprecated('Use sendTOTPResponseDescriptor instead')
const SendTOTPResponse$json = const {
  '1': 'SendTOTPResponse',
};

/// Descriptor for `SendTOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendTOTPResponseDescriptor = $convert.base64Decode('ChBTZW5kVE9UUFJlc3BvbnNl');
@$core.Deprecated('Use getTOTPRequestDescriptor instead')
const GetTOTPRequest$json = const {
  '1': 'GetTOTPRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetTOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTOTPRequestDescriptor = $convert.base64Decode('Cg5HZXRUT1RQUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');
@$core.Deprecated('Use getTOTPResponseDescriptor instead')
const GetTOTPResponse$json = const {
  '1': 'GetTOTPResponse',
  '2': const [
    const {'1': 'response', '3': 1, '4': 1, '5': 11, '6': '.api.v1.TOTPResponse', '10': 'response'},
  ],
};

/// Descriptor for `GetTOTPResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTOTPResponseDescriptor = $convert.base64Decode('Cg9HZXRUT1RQUmVzcG9uc2USMAoIcmVzcG9uc2UYASABKAsyFC5hcGkudjEuVE9UUFJlc3BvbnNlUghyZXNwb25zZQ==');
@$core.Deprecated('Use tOTPRequestDescriptor instead')
const TOTPRequest$json = const {
  '1': 'TOTPRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.api.v1.TOTPRequestType', '10': 'type'},
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'response_type', '3': 4, '4': 1, '5': 14, '6': '.api.v1.TOTPResponseType', '10': 'responseType'},
  ],
};

/// Descriptor for `TOTPRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tOTPRequestDescriptor = $convert.base64Decode('CgtUT1RQUmVxdWVzdBIrCgR0eXBlGAEgASgOMhcuYXBpLnYxLlRPVFBSZXF1ZXN0VHlwZVIEdHlwZRIOCgJpZBgCIAEoCVICaWQSEgoEbmFtZRgDIAEoCVIEbmFtZRI9Cg1yZXNwb25zZV90eXBlGAQgASgOMhguYXBpLnYxLlRPVFBSZXNwb25zZVR5cGVSDHJlc3BvbnNlVHlwZQ==');
const $core.Map<$core.String, $core.dynamic> ServiceBase$json = const {
  '1': 'Service',
  '2': const [
    const {'1': 'SendTOTP', '2': '.api.v1.SendTOTPRequest', '3': '.api.v1.SendTOTPResponse', '4': const {}},
    const {'1': 'GetTOTP', '2': '.api.v1.GetTOTPRequest', '3': '.api.v1.GetTOTPResponse', '4': const {}},
  ],
};

@$core.Deprecated('Use serviceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> ServiceBase$messageJson = const {
  '.api.v1.SendTOTPRequest': SendTOTPRequest$json,
  '.api.v1.TOTPResponse': TOTPResponse$json,
  '.api.v1.SendTOTPResponse': SendTOTPResponse$json,
  '.api.v1.GetTOTPRequest': GetTOTPRequest$json,
  '.api.v1.GetTOTPResponse': GetTOTPResponse$json,
};

/// Descriptor for `Service`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List serviceDescriptor = $convert.base64Decode('CgdTZXJ2aWNlEj8KCFNlbmRUT1RQEhcuYXBpLnYxLlNlbmRUT1RQUmVxdWVzdBoYLmFwaS52MS5TZW5kVE9UUFJlc3BvbnNlIgASPAoHR2V0VE9UUBIWLmFwaS52MS5HZXRUT1RQUmVxdWVzdBoXLmFwaS52MS5HZXRUT1RQUmVzcG9uc2UiAA==');
