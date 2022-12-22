import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:vepiot/gen/api/v1/api.pb.dart';
import 'package:vepiot/notification.dart';
import 'package:vepiot/storage.dart';

import 'firebase_options.dart';

class FCM extends ChangeNotifier {
  @pragma('vm:entry-point')
  static Future<void> totpRequest(RemoteMessage message) async {
    TOTPRequest request = TOTPRequest.create()
      ..mergeFromProto3Json(jsonDecode(message.data["proto"]));

    await StorageService.readOTP();
    if (!StorageService.OTPs.value.containsKey(request.name)) {
      return;
    }

    var token = await StorageService.readFCMToken();
    var otp = StorageService.OTPs.value[request.name]!;

    switch (request.type) {
      case TOTPRequestType.TOTP_REQUEST_TYPE_REQUEST:
        otp.requestId = request.id;
        break;
      case TOTPRequestType.TOTP_REQUEST_TYPE_RESPONSE:
      case TOTPRequestType.TOTP_REQUEST_TYPE_CANCEL:
        otp.requestId = null;
        break;
      case TOTPRequestType.TOTP_REQUEST_TYPE_UNSPECIFIED:
        break;
    }

    StorageService.OTPs.notifyListeners();
    await StorageService.writeOTP();
    await NotificationService.fireNotification(request, token!);
  }

  static void init(context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseMessaging.instance.getToken();

    NotificationService.init(context);

    // NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
    //
    // switch (settings.authorizationStatus) {
    //   case AuthorizationStatus.authorized:
    //     break;
    //   case AuthorizationStatus.denied:
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text("Notification Permission required please activate it manually."),
    //     ));
    //     break;
    //   case AuthorizationStatus.notDetermined:
    //     break;
    //   case AuthorizationStatus.provisional:
    //     break;
    // }

    FirebaseMessaging.onBackgroundMessage(totpRequest);
    FirebaseMessaging.onMessage.listen(totpRequest);
  }

  static Future<String?> getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    await StorageService.writeFCMToken(token);
    return token;
  }
}
