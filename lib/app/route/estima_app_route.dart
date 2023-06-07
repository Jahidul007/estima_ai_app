
import 'package:estima_ai_app/app/module/auth/login/screen/login_screen.dart';
import 'package:estima_ai_app/app/module/auth/registration/screen/registration_screen.dart';
import 'package:estima_ai_app/app/module/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class EstimaAppRoute {
  static const String splash = "/splash";
  static const String authScreen = "/auth";
  static const String registrationScreen = "/registration";

}

MaterialPageRoute? getEstimaAppRoutes(RouteSettings settings) {

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        settings: const RouteSettings(name: EstimaAppRoute.splash),
        builder: (_) =>  const SplashScreen(),
      );

    case EstimaAppRoute.authScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: EstimaAppRoute.authScreen),
        builder: (_) =>  const LoginScreen(),
      );
    case EstimaAppRoute.registrationScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: EstimaAppRoute.registrationScreen),
        builder: (_) =>  const RegistrationScreen(),
      );

    default:
      return null;
  }
}
