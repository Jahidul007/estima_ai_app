import 'dart:async';
import 'dart:io';

import 'package:core/di/setup_core.dart';
import 'package:core/network/error_handlers.dart';
import 'package:core/screen/token_expiry_handler.dart';
import 'package:core/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

import 'route/route_generator.dart';

class EstimaApp extends StatefulWidget {
  const EstimaApp({Key? key}) : super(key: key);

  @override
  _EstimaAppState createState() => _EstimaAppState();
}

class _EstimaAppState extends State<EstimaApp> {
  late final StreamSubscription onMessageSubscription;
  late final StreamSubscription onMessageOpenedSubscription;

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  final _sessionConfig = SessionConfig(
    invalidateSessionForAppLostFocus: const Duration(minutes: 5),
    invalidateSessionForUserInactivity: const Duration(minutes: 5),
  );

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setOrientation();
    initFirebase();
    _setUserActivityTracker();
  }

  void _setUserActivityTracker() {
    _sessionConfig.stream.listen(
          (SessionTimeoutState timeoutEvent) {
        if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
          getIt<TokenExpiryHandler>().onTokenExpired(_navigator.context);
        } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
          getIt<TokenExpiryHandler>().onTokenExpired(_navigator.context);
        }
      },
    );
  }

  initFirebase() async {
    await initFirebaseMessaging();
  }

  initFirebaseMessaging() async {
    await Firebase.initializeApp();

    await _requestPermission();

    //for ios
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    addMessageListeners();
    //   _getFcmMessage();
  }

  _requestPermission() async {
    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    logger.d('User granted permission: ${settings.authorizationStatus}');
  }



  void addMessageListeners() async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings("ic_notification_icon"),
          iOS: DarwinInitializationSettings()),
    );

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    } else {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // when the app is in the foreground
    onMessageSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          logger.d('onMessage: Got a message whilst in the foreground!');
          logger.d('onMessage: Message data::: ${message.data}');

          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;

          final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                ),
              ),
            );
          }

          if (message.notification != null) {
            logger.d(
                'onMessage: Message also contained a notification: ${message.notification}');
          }
        });
  }

  _setOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() async {
    super.dispose();

    await onMessageSubscription.cancel();
    await onMessageOpenedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'EstimaAI',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: const Color(0xff800080),
        textTheme: const TextTheme(
            labelLarge: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(0xff800080, primaryColorMap),
        )
            .copyWith(secondary: primaryColor)
            .copyWith(background: dashboardBgColor),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
