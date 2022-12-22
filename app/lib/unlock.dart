import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:vepiot/fcm.dart';
import 'package:vepiot/unlocker.dart';

import 'gen/api/v1/api.pb.dart';
import 'otp.dart';

class UnlockScreen extends StatefulWidget {
  final String id;
  final String name;
  final OTP otp;

  const UnlockScreen(
      {required this.id, required this.name, required this.otp, super.key});

  @override
  State<StatefulWidget> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends State<UnlockScreen> {
  Future<void> handle(bool allow) async {
    var deviceId = await FCM.getToken();

    TOTPResponseType type = TOTPResponseType.TOTP_RESPONSE_TYPE_UNSPECIFIED;
    if (allow) {
      type = TOTPResponseType.TOTP_RESPONSE_TYPE_ALLOW;
    } else {
      type = TOTPResponseType.TOTP_RESPONSE_TYPE_DENY;
    }

    http.Response resp = await UnlockService.handle(TOTPResponse(
      id: widget.id,
      deviceId: deviceId,
      name: widget.name,
      type: type,
    ), widget.otp);

    if (mounted && resp.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${resp.statusCode}: ${resp.body}'),
      ));
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unlock - ${widget.otp.username}"),
      ),
      body: const Center(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => handle(false),
                child: const Text(
                  'Deny',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => handle(true),
                child: const Text(
                  'Allow',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
