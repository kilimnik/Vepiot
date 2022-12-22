import 'dart:convert';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:vepiot/otp.dart';

import 'gen/api/v1/api.pb.dart';
import 'package:http/http.dart' as http;

class UnlockService {
  static Future<http.Response> handle(TOTPResponse response, OTP otp) async {
    response.totpCode = otp.generateCode();

    var request = SendTOTPRequest(
      response: response,
    );

    if (!Settings.isInitialized) {
      await Settings.init();
    }
    var uri = Settings.getValue<String>("proxy-url");

    var resp = await http.post(
      Uri.parse('$uri/api.v1.Service/SendTOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toProto3Json()),
    );

    return resp;
  }
}
