import 'dart:async';
import 'package:core/di/setup_core.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:core/utils/constants.dart';
import 'package:estima_ai_app/app/module/splash/controller/splash_controller.dart';
import 'package:estima_ai_app/app/route/estima_app_route.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CompositeSubscription subscription = CompositeSubscription();

  final SplashController _splashController = getIt.get<SplashController>();

  BuildContext? _context;

  @override
  void initState() {
    super.initState();
    getLocalization();
  }

  getLocalization() async {
    await _splashController.getLocalization();
    await clearUserInfo();
    await nextRoute();
  }

  clearUserInfo() async {
    PreferenceManager preferenceManager = getIt.get<PreferenceManager>();
    await preferenceManager.removeLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff317773),
          image: DecorationImage(
              image: AssetImage("images/splash_mask.png"), fit: BoxFit.fill),
        ),
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Theme.of(context).primaryColor,
            child: Text(
              "EstimaAI",style: titleTag.copyWith(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }

  nextRoute() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(_context!,EstimaAppRoute.authScreen,
          arguments: null);
    });
  }

  @override
  void dispose() {
    subscription.dispose();
    super.dispose();
  }
}
