///
//  Generated code. Do not modify.
//  source: api/v1/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'api.pbenum.dart';

export 'api.pbenum.dart';

class TOTPResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TOTPResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api.v1'), createEmptyInstance: create)
    ..e<TOTPResponseType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: TOTPResponseType.TOTP_RESPONSE_TYPE_UNSPECIFIED, valueOf: TOTPResponseType.valueOf, enumValues: TOTPResponseType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totpCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  TOTPResponse._() : super();
  factory TOTPResponse({
    TOTPResponseType? type,
    $core.String? id,
    $core.String? totpCode,
    $core.String? deviceId,
    $core.String? name,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (id != null) {
      _result.id = id;
    }
    if (totpCode != null) {
      _result.totpCode = totpCode;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory TOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TOTPResponse clone() => TOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TOTPResponse copyWith(void Function(TOTPResponse) updates) => super.copyWith((message) => updates(message as TOTPResponse)) as TOTPResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TOTPResponse create() => TOTPResponse._();
  TOTPResponse createEmptyInstance() => create();
  static $pb.PbList<TOTPResponse> createRepeated() => $pb.PbList<TOTPResponse>();
  @$core.pragma('dart2js:noInline')
  static TOTPResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TOTPResponse>(create);
  static TOTPResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TOTPResponseType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(TOTPResponseType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get totpCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set totpCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotpCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotpCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceId => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(5)
  set name($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(5)
  void clearName() => clearField(5);
}

class SendTOTPRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendTOTPRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api.v1'), createEmptyInstance: create)
    ..aOM<TOTPResponse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'response', subBuilder: TOTPResponse.create)
    ..hasRequiredFields = false
  ;

  SendTOTPRequest._() : super();
  factory SendTOTPRequest({
    TOTPResponse? response,
  }) {
    final _result = create();
    if (response != null) {
      _result.response = response;
    }
    return _result;
  }
  factory SendTOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendTOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendTOTPRequest clone() => SendTOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendTOTPRequest copyWith(void Function(SendTOTPRequest) updates) => super.copyWith((message) => updates(message as SendTOTPRequest)) as SendTOTPRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendTOTPRequest create() => SendTOTPRequest._();
  SendTOTPRequest createEmptyInstance() => create();
  static $pb.PbList<SendTOTPRequest> createRepeated() => $pb.PbList<SendTOTPRequest>();
  @$core.pragma('dart2js:noInline')
  static SendTOTPRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendTOTPRequest>(create);
  static SendTOTPRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TOTPResponse get response => $_getN(0);
  @$pb.TagNumber(1)
  set response(TOTPResponse v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponse() => clearField(1);
  @$pb.TagNumber(1)
  TOTPResponse ensureResponse() => $_ensure(0);
}

class SendTOTPResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendTOTPResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SendTOTPResponse._() : super();
  factory SendTOTPResponse() => create();
  factory SendTOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendTOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendTOTPResponse clone() => SendTOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendTOTPResponse copyWith(void Function(SendTOTPResponse) updates) => super.copyWith((message) => updates(message as SendTOTPResponse)) as SendTOTPResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendTOTPResponse create() => SendTOTPResponse._();
  SendTOTPResponse createEmptyInstance() => create();
  static $pb.PbList<SendTOTPResponse> createRepeated() => $pb.PbList<SendTOTPResponse>();
  @$core.pragma('dart2js:noInline')
  static SendTOTPResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendTOTPResponse>(create);
  static SendTOTPResponse? _defaultInstance;
}

class GetTOTPRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTOTPRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  GetTOTPRequest._() : super();
  factory GetTOTPRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetTOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTOTPRequest clone() => GetTOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTOTPRequest copyWith(void Function(GetTOTPRequest) updates) => super.copyWith((message) => updates(message as GetTOTPRequest)) as GetTOTPRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTOTPRequest create() => GetTOTPRequest._();
  GetTOTPRequest createEmptyInstance() => create();
  static $pb.PbList<GetTOTPRequest> createRepeated() => $pb.PbList<GetTOTPRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTOTPRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTOTPRequest>(create);
  static GetTOTPRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetTOTPResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTOTPResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api.v1'), createEmptyInstance: create)
    ..aOM<TOTPResponse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'response', subBuilder: TOTPResponse.create)
    ..hasRequiredFields = false
  ;

  GetTOTPResponse._() : super();
  factory GetTOTPResponse({
    TOTPResponse? response,
  }) {
    final _result = create();
    if (response != null) {
      _result.response = response;
    }
    return _result;
  }
  factory GetTOTPResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTOTPResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTOTPResponse clone() => GetTOTPResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTOTPResponse copyWith(void Function(GetTOTPResponse) updates) => super.copyWith((message) => updates(message as GetTOTPResponse)) as GetTOTPResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTOTPResponse create() => GetTOTPResponse._();
  GetTOTPResponse createEmptyInstance() => create();
  static $pb.PbList<GetTOTPResponse> createRepeated() => $pb.PbList<GetTOTPResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTOTPResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTOTPResponse>(create);
  static GetTOTPResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TOTPResponse get response => $_getN(0);
  @$pb.TagNumber(1)
  set response(TOTPResponse v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponse() => clearField(1);
  @$pb.TagNumber(1)
  TOTPResponse ensureResponse() => $_ensure(0);
}

class TOTPRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TOTPRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'api.v1'), createEmptyInstance: create)
    ..e<TOTPRequestType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: TOTPRequestType.TOTP_REQUEST_TYPE_UNSPECIFIED, valueOf: TOTPRequestType.valueOf, enumValues: TOTPRequestType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<TOTPResponseType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'responseType', $pb.PbFieldType.OE, defaultOrMaker: TOTPResponseType.TOTP_RESPONSE_TYPE_UNSPECIFIED, valueOf: TOTPResponseType.valueOf, enumValues: TOTPResponseType.values)
    ..hasRequiredFields = false
  ;

  TOTPRequest._() : super();
  factory TOTPRequest({
    TOTPRequestType? type,
    $core.String? id,
    $core.String? name,
    TOTPResponseType? responseType,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (responseType != null) {
      _result.responseType = responseType;
    }
    return _result;
  }
  factory TOTPRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TOTPRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TOTPRequest clone() => TOTPRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TOTPRequest copyWith(void Function(TOTPRequest) updates) => super.copyWith((message) => updates(message as TOTPRequest)) as TOTPRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TOTPRequest create() => TOTPRequest._();
  TOTPRequest createEmptyInstance() => create();
  static $pb.PbList<TOTPRequest> createRepeated() => $pb.PbList<TOTPRequest>();
  @$core.pragma('dart2js:noInline')
  static TOTPRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TOTPRequest>(create);
  static TOTPRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TOTPRequestType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(TOTPRequestType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  TOTPResponseType get responseType => $_getN(3);
  @$pb.TagNumber(4)
  set responseType(TOTPResponseType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasResponseType() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponseType() => clearField(4);
}

class ServiceApi {
  $pb.RpcClient _client;
  ServiceApi(this._client);

  $async.Future<SendTOTPResponse> sendTOTP($pb.ClientContext? ctx, SendTOTPRequest request) {
    var emptyResponse = SendTOTPResponse();
    return _client.invoke<SendTOTPResponse>(ctx, 'Service', 'SendTOTP', request, emptyResponse);
  }
  $async.Future<GetTOTPResponse> getTOTP($pb.ClientContext? ctx, GetTOTPRequest request) {
    var emptyResponse = GetTOTPResponse();
    return _client.invoke<GetTOTPResponse>(ctx, 'Service', 'GetTOTP', request, emptyResponse);
  }
}

