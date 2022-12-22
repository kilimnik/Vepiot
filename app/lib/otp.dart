import 'package:json_annotation/json_annotation.dart';

import 'package:otp/otp.dart' as otp_generator;
import 'package:otp/otp.dart';

part 'otp.g.dart';

// ignore: camel_case_types
enum OTP_Type {
  none,
  totp,
  hotp,
}

@JsonSerializable()
class OTP {
  String secret;
  OTP_Type type;
  String username;
  String issuer;
  String? requestId;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory OTP.fromJson(Map<String, dynamic> json) => _$OTPFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OTPToJson(this);

  OTP(this.secret, this.type, this.username, this.issuer);

  String generateCode() {
    switch (type) {
      case OTP_Type.none:
        return "";
      case OTP_Type.totp:
        var currentTime = DateTime.now().toLocal().millisecondsSinceEpoch;
        return otp_generator.OTP.generateTOTPCodeString(secret, currentTime,
            isGoogle: true, algorithm: Algorithm.SHA1);
      case OTP_Type.hotp:
        return "";
    }
  }

  static OTP createOTP(String stringUri) {
    var uri = Uri.parse(stringUri);

    if (!uri.isScheme("otpauth")) {
      throw FormatException("Wrong scheme ${uri.scheme}");
    }

    var type = OTP_Type.none;
    switch (uri.authority) {
      case "totp":
        type = OTP_Type.totp;
        break;
      case "hotp":
        type = OTP_Type.hotp;
        throw const FormatException("HOTP not supported");
      default:
        throw FormatException("Wrong OTP Type ${uri.authority}");
    }

    var params = uri.queryParameters;

    if (!params.containsKey("secret")) {
      throw const FormatException("No secret provided");
    }
    var secret = params["secret"]!;

    if (!params.containsKey("issuer")) {
      throw const FormatException("No issuer provided");
    }
    var issuer = params["issuer"]!;

    var splits = uri.pathSegments[0].split(":");
    if (splits.length != 2) {
      throw const FormatException("OTP Format Wrong");
    }

    var username = splits[1];
    if (splits[0] != issuer) {
      throw const FormatException("Issuer not matching");
    }

    return OTP(secret, type, username, issuer);
  }
}
