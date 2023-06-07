import 'package:core/controller/global_controller.dart';
import 'package:core/localizations/controller/localization_controller.dart';
import 'package:core/localizations/data/data_provider/local_response_core_provider.dart';
import 'package:core/network/dio_provider.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:core/network/preference_manager/preference_manager_impl.dart';
import 'package:core/screen/token_expiry_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

GetIt getIt = GetIt.instance;

class CoreNetworkConfig {
  String baseUrl;
  TokenExpiryHandler tokenExpiryHandler;

  CoreNetworkConfig({required this.baseUrl, required this.tokenExpiryHandler});
}

void setupCore(CoreNetworkConfig networkConfig) {
  getIt.allowReassignment = true;
  getIt.registerSingleton<String>(networkConfig.baseUrl, instanceName: 'baseUrl');
  getIt.registerLazySingleton<Dio>(
      () => httpDio(baseUrl: networkConfig.baseUrl),
      instanceName:  (httpDio).toString());
  getIt.registerLazySingleton<CoreNetworkConfig>(() => networkConfig);
  getIt.registerLazySingleton<PreferenceManager>(() => PreferenceManagerImpl());
  getIt.registerLazySingleton<Logger>(() => Logger());
  getIt.registerLazySingleton(() => LocalizationController());
  getIt.registerLazySingleton(() => LocalResponseCoreDataProvider());
  getIt.registerLazySingleton(() => networkConfig.tokenExpiryHandler);
  getIt.registerLazySingleton(() => GlobalController());
}
