import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to open app',
          options: const AuthenticationOptions(
            sensitiveTransaction: true,
          )
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      return false;
    }
  }
}