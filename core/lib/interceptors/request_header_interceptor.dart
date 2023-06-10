import 'package:core/controller/global_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:dio/dio.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {

  String getContentType({String? versionNo}) {
    return "application/json";
  }


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    var accessToken = "";
    var langCode = "";

    GlobalController globalController = getIt.get<GlobalController>();

    if (globalController.getAccessToken().isEmpty) {
      accessToken = await getIt.get<PreferenceManager>().getToken();
      globalController.setAccessToken(accessToken);
    }
    if(accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    //options.headers['Content-Type'] = getContentType();

    if (globalController.getLangCode().isEmpty) {
      langCode = await getIt.get<PreferenceManager>().getLocalization();
      globalController.setLangCode(langCode);
    }
    return super.onRequest(options, handler);
  }
}