import 'package:estima_ai_app/app/di/setup_di.dart';
import 'package:estima_ai_app/app/module/flavor/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/estima_ai_app.dart';
import 'app/module/flavor/flavor_config.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  _resetStorage();
  _setupFlavor();
  await setup();
  runApp(const EstimaApp());
}

void _setupFlavor() {
  Config devConfig = Config(
      baseUrl: "http://localhost:7788",
      webPushBaseUrl:
      "http://cpayservicedev.southeastasia.cloudapp.azure.com:5030",
      isDemo: true,
      shouldCollectCrashLog: false,
      clientSecret: "e16e15e8-1774-47f9-8d73-230ffbfaa84f",
      keyClockClientId: "wallet-app-customer");

  FlavorConfig(flavor: Flavor.dev, config: devConfig);
}

void _resetStorage() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('first_run') ?? true) {
    var storage = const FlutterSecureStorage();

    await storage.deleteAll();

    prefs.setBool('first_run', false);
  }
}

