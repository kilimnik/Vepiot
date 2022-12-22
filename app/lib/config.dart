import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class ConfigScreen extends StatelessWidget {
  ConfigScreen({key}) : super(key: key) {
    if (!Settings.containsKey('proxy-url')!) {
      Settings.setValue('proxy-url', "http://127.0.0.1:8080");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Application Settings",
      children: [
        TextInputSettingsTile(
          title: 'Proxy Server',
          settingKey: 'proxy-url',
          initialValue: 'http://127.0.0.1:8080',
          borderColor: Colors.blueAccent,
          errorColor: Colors.deepOrangeAccent,
        ),
      ],
    );
  }
}