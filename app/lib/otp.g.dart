// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTP _$OTPFromJson(Map<String, dynamic> json) => OTP(
      json['secret'] as String,
      $enumDecode(_$OTP_TypeEnumMap, json['type']),
      json['username'] as String,
      json['issuer'] as String,
    )..requestId = json['requestId'] as String?;

Map<String, dynamic> _$OTPToJson(OTP instance) => <String, dynamic>{
      'secret': instance.secret,
      'type': _$OTP_TypeEnumMap[instance.type]!,
      'username': instance.username,
      'issuer': instance.issuer,
      'requestId': instance.requestId,
    };

const _$OTP_TypeEnumMap = {
  OTP_Type.none: 'none',
  OTP_Type.totp: 'totp',
  OTP_Type.hotp: 'hotp',
};
