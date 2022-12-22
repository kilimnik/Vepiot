///
//  Generated code. Do not modify.
//  source: api/v1/api.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'api.pb.dart' as $0;
import 'api.pbjson.dart';

export 'api.pb.dart';

abstract class ServiceBase extends $pb.GeneratedService {
  $async.Future<$0.SendTOTPResponse> sendTOTP($pb.ServerContext ctx, $0.SendTOTPRequest request);
  $async.Future<$0.GetTOTPResponse> getTOTP($pb.ServerContext ctx, $0.GetTOTPRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'SendTOTP': return $0.SendTOTPRequest();
      case 'GetTOTP': return $0.GetTOTPRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'SendTOTP': return this.sendTOTP(ctx, request as $0.SendTOTPRequest);
      case 'GetTOTP': return this.getTOTP(ctx, request as $0.GetTOTPRequest);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => ServiceBase$messageJson;
}

