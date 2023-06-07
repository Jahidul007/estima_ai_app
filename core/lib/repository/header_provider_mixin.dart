import 'package:core/di/setup_core.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:dio/dio.dart';

mixin HeaderProvider {
  Future<Options> getHeaders({String? versionCode = "1"}) async {
    PreferenceManager preferenceManager = getIt.get<PreferenceManager>();
    final accessToken = await preferenceManager.getToken();
    final lnCode = await preferenceManager.getLocalization();

    final option = accessToken.isNotEmpty?Options(
      headers: <String, String>{
        'Authorization': accessToken.isNotEmpty?"Bearer $accessToken":"",
        'Content-Type' : getAcceptHeaderType(versionNo: versionCode),
        'Accept' : getAcceptHeaderType(versionNo: versionCode),
        'Accept-Language': lnCode,
      },
    ): Options(headers: <String, String>{
      'Content-Type' : getAcceptHeaderType(versionNo: versionCode),
    });

    return option;
  }

  String getContentType({String? versionNo}) {
    return "application/json";
  }
  String getAcceptHeaderType({String? versionNo}) {
    return "application/json";
  }
}