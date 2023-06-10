import 'package:core/di/setup_core.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:dio/dio.dart';

mixin HeaderProvider {
  Future<Options> getHeaders(
      {String? versionCode = "1", bool isPDF = false}) async {
    PreferenceManager preferenceManager = getIt.get<PreferenceManager>();
    final accessToken = await preferenceManager.getToken();
    final lnCode = await preferenceManager.getLocalization();

    final option = accessToken.isNotEmpty
        ? Options(
            headers: <String, String>{
              'Authorization':
                  accessToken.isNotEmpty ? "Bearer $accessToken" : "",
              'Content-Type': isPDF
                  ? getContentTypeForPdf(versionNo: versionCode)
                  : getContentType(versionNo: versionCode),
              'Accept': "*/*",
              'Accept-Language': lnCode,
            },
          )
        : Options(headers: <String, String>{
            'Content-Type': getAcceptHeaderType(versionNo: versionCode),
          });

    return option;
  }

  String getContentType({String? versionNo}) {
    return "application/json";
  }

  String getContentTypeForPdf({String? versionNo}) {
    return "application/pdf";
  }

  String getAcceptHeaderType({String? versionNo}) {
    return "application/json";
  }
}
