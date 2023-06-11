import 'package:estima_ai_app/app/module/auth/login/screen/login_screen.dart';
import 'package:estima_ai_app/app/module/auth/registration/screen/registration_screen.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_profile_history_response.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/dashboard_screen.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/details/user_stories_details_screen.dart';
import 'package:estima_ai_app/app/module/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class EstimaAppRoute {
  static const String splash = "/splash";
  static const String authScreen = "/login";
  static const String registrationScreen = "/registration";
  static const String dashboardScreen = "/dashboard";
  static const String userHistoryDetailsScreen = "/historyDetails";
}

MaterialPageRoute? getEstimaAppRoutes(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        settings: const RouteSettings(name: EstimaAppRoute.splash),
        builder: (_) => const SplashScreen(),
      );

    case EstimaAppRoute.authScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: EstimaAppRoute.authScreen),
        builder: (_) => const LoginScreen(),
      );
    case EstimaAppRoute.registrationScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: EstimaAppRoute.registrationScreen),
        builder: (_) => const RegistrationScreen(),
      );

    case EstimaAppRoute.dashboardScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: EstimaAppRoute.dashboardScreen),
        builder: (_) => const DashboardScreen(),
      );

    case EstimaAppRoute.userHistoryDetailsScreen:
      ReportHistories? reportHistories;
      if (args is ReportHistories) {
        reportHistories = args;
      }
      return MaterialPageRoute(
        settings:
            const RouteSettings(name: EstimaAppRoute.userHistoryDetailsScreen),
        builder: (_) => UserStoriesDetailsScreen(
          reportHistories: reportHistories!,
        ),
      );

    default:
      return null;
  }
}
