import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'otp.dart';

class StorageService {
  static const _secureStorage = FlutterSecureStorage();
  static const otpKey = "OTP";
  static const fcmKey = "fcm";

  static ValueNotifier<Map<String, OTP>> OTPs = ValueNotifier<Map<String, OTP>>({});

  static Future<void> init() async {
    await readOTP();
  }

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  static Future<void> writeOTP() async {
    var json = jsonEncode(OTPs.value);
    await _secureStorage.write(
        key: otpKey, value: json, aOptions: _getAndroidOptions());
  }

  static Future<void> readOTP() async {
    var containsKey = await _secureStorage.containsKey(
        key: otpKey, aOptions: _getAndroidOptions());
    if (!containsKey) {
      return;
    }

    var json =
        await _secureStorage.read(key: otpKey, aOptions: _getAndroidOptions());

    Map<String, dynamic> data = jsonDecode(json!);
    Map<String, OTP> map =
        data.map((name, data) => MapEntry(name, OTP.fromJson(data)));

    OTPs.value = map;
  }

  static Future<void> writeFCMToken(String? token) async {
    await _secureStorage.write(
        key: fcmKey, value: token, aOptions: _getAndroidOptions());
  }

  static Future<String?> readFCMToken() async {
    var containsKey = await _secureStorage.containsKey(
        key: fcmKey, aOptions: _getAndroidOptions());
    if (!containsKey) {
      return null;
    }

    return await _secureStorage.read(key: fcmKey, aOptions: _getAndroidOptions());
  }
}
