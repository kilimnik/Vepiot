import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vepiot/storage.dart';
import 'package:vepiot/unlocker.dart';

import 'gen/api/v1/api.pb.dart';
import 'dart:developer' as developer;

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init(context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_logo');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    bool? granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    if (granted != null && !granted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Notification Permission required please activate it manually."),
      ));
    }
  }

  static Future<void> fireNotification(
      TOTPRequest request, String deviceId) async {
    switch (request.type) {
      case TOTPRequestType.TOTP_REQUEST_TYPE_REQUEST:
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          request.id,
          'unlock_request',
          channelDescription: 'Unlock Request for Vault',
          importance: Importance.max,
          priority: Priority.high,
        );
        NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);

        await flutterLocalNotificationsPlugin.show(
            request.id.hashCode,
            'Vepiot Verify Unlock',
            'Someone wants to unlock Vault Auth ${request.name}',
            notificationDetails);
        break;
      case TOTPRequestType.TOTP_REQUEST_TYPE_RESPONSE:
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(request.id, 'unlocked',
                channelDescription: 'Unlocked Vault',
                importance: Importance.max,
                priority: Priority.high);
        NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);

        await flutterLocalNotificationsPlugin.show(
            0,
            'Vepiot Verify Unlocked',
            'Someone unlocked Vault Auth ${request.name}',
            notificationDetails);
        await cancelNotification(request.id.hashCode);
        break;
      case TOTPRequestType.TOTP_REQUEST_TYPE_CANCEL:
        await cancelNotification(request.id.hashCode);
        break;
      case TOTPRequestType.TOTP_REQUEST_TYPE_UNSPECIFIED:
        break;
    }
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
