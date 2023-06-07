import 'package:core/di/setup_core.dart';
import 'package:core/localizations/controller/language_selection_controller.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:core/network/preference_manager/preference_manager_impl.dart';
import 'package:estima_ai_app/app/module/auth/login/data/repository/access_token_repository.dart';
import 'package:estima_ai_app/app/module/auth/registration/data/repository/user_registration_repository.dart';
import 'package:estima_ai_app/app/module/flavor/flavor_config.dart';
import 'package:estima_ai_app/app/module/splash/controller/splash_controller.dart';
import 'package:estima_ai_app/app/module/splash/controller/token_expiry_wallet_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

const String dioOptionsWithToken = "dioOptionsWithToken";

Future<void> setup() async {
  _setupCoreDependencies();

  getIt.registerLazySingleton<Logger>(() => Logger());

  getIt.registerLazySingleton<PreferenceManager>(() => PreferenceManagerImpl());

  _initializeNotification();


  getIt.registerLazySingleton<PreferenceManager>(
    () => PreferenceManagerImpl(),
    instanceName: ("preferenceManagerImpl").toString(),
  );

  _setUpRepository();
  _setupController();
}

/// Setup Core dependencies
void _setupCoreDependencies() {
  setupCore(
    CoreNetworkConfig(
      baseUrl: FlavorConfig.instance.config.baseUrl,
      tokenExpiryHandler: TokenExpiryHandlerWallet(),
    ),
  );
}



_setUpRepository() {
  getIt.registerLazySingleton<AccessTokenRepository>(() => AccessTokenRepository());
  getIt.registerLazySingleton<UseRegistrationRepository>(() => UseRegistrationRepository());
}

_setupController() {
  getIt.registerLazySingleton<SplashController>(() => SplashController());
  getIt.registerLazySingleton(
    () => LanguageSelectionController(),
  );
}



// todo move this to notification module
void _initializeNotification() async {
  //todo massive change
  FlutterSecureStorage sharedPreferences = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));
  getIt.registerLazySingleton<FlutterSecureStorage>(() => sharedPreferences);

}
