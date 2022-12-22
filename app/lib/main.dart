import 'dart:async';
import 'package:flutter/services.dart';
import 'package:vepiot/storage.dart';
import 'package:vepiot/unlock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'auth.dart';
import 'config.dart';
import 'fcm.dart';
import 'otp.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Settings.init();
  await StorageService.init();
  var authenticated = await authenticate();

  if (authenticated) {
    runApp(const VepiotApp());
  }
}

Future<bool> authenticate() async {
  bool authenticated = await AuthenticationService.authenticate();

  if (!authenticated) {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  return authenticated;
}

class VepiotApp extends StatelessWidget {
  const VepiotApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vepiot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(0xFFFDBB05, <int, Color>{
          50: Color(0xFFFFF7E1),
          100: Color(0xFFFEEBB4),
          200: Color(0xFFFEDD82),
          300: Color(0xFFFECF50),
          400: Color(0xFFFDC52B),
          500: Color(0xFFFDBB05),
          600: Color(0xFFFDB504),
          700: Color(0xFFFCAC04),
          800: Color(0xFFFCA403),
          900: Color(0xFFFC9601),
        })).copyWith(secondary: const MaterialColor(0xFFFFF8EF, <int, Color>{
          100: Color(0xFFFFFFFF),
          200: Color(0xFFFFF8EF),
          400: Color(0xFFFFE0BC),
          700: Color(0xFFFFD5A2),
        })),
      ),
      home: const MyHomePage(title: 'Vepiot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    FCM.init(context);

    super.initState();

    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //     await StorageService.readOTP();
    //     setState(() {
    //
    //     });
    // });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await StorageService.readOTP();
      await authenticate();
    }
  }

  Future scan() async {
    ScanResult result = await BarcodeScanner.scan();
    String uri = result.rawContent;

    var errorMessage = "";

    try {
      OTP otp = OTP.createOTP(uri);
      setState(() => StorageService.OTPs.value[otp.username] = otp);
      await StorageService.writeOTP();
    } on FormatException catch (e) {
      errorMessage = e.message;
    }

    if (errorMessage.isNotEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    }
  }

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'Settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfigScreen()),
        );
        break;
      case 'Firebase Device Id':
        String? token = await FCM.getToken();
        if (token != null) {
          Share.share(token);
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No Firebase Token found"),
          ));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vepiot"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Settings', 'Firebase Device Id'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        tooltip: 'Add TOTP',
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: StorageService.OTPs,
        builder: (context, Map<String, OTP> value, child) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              OTP otp = value.values.elementAt(index);
              return Dismissible(
                key: Key(otp.username),
                onDismissed: (direction) async {
                  setState(() {
                    value.remove(otp.username);
                  });
                  await StorageService.writeOTP();
                },
                child: Card(
                  child: ListTile(
                    title: Text(otp.username),
                    trailing: otp.requestId != null
                        ? const Icon(Icons.notifications_active)
                        : const Icon(null),
                    onTap: () {
                      if (otp.requestId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UnlockScreen(
                                  id: otp.requestId!,
                                  name: otp.issuer,
                                  otp: otp)),
                        );
                      }
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
