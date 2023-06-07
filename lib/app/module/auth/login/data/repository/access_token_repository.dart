import 'dart:convert';

import 'package:core/model/auth/data/model/access_token_request_response.dart';
import 'package:core/network/error_handlers.dart';
import 'package:dio/dio.dart';
import 'package:core/repository/base_repository.dart';
import 'package:estima_ai_app/app/module/flavor/flavor_config.dart';

class AccessTokenRepository extends BaseRepository {
  Future<AccessTokenRequestResponse> getAccessTokenResponse(
      String username, String password,
      {String? newPassword}) async {
    Map<String, dynamic> body = {
      "clientId": FlavorConfig.instance.config.keyClockClientId,
      "clientSecrete": FlavorConfig.instance.config.clientSecret,
      "grantType": "password",
      "password": password,
      "username": username,
    };

    try {
      var response = await apiHelper.post(
          "/api/auth/login", jsonEncode(body));

      if (response.statusCode == 200) {
        return AccessTokenRequestResponse.fromJson(response.data)
          ..isSuccess = true;
      } else {
        return AccessTokenRequestResponse.responseWithError(
            "Something went wrong")
          ..responseCode = response.statusCode;
      }
    } on DioError catch (e) {
      String error = handleDioError(e);
      return AccessTokenRequestResponse.responseWithError(error)
        ..responseCode = e.response?.statusCode;
    } catch (error) {
      return AccessTokenRequestResponse.responseWithError(
          "Something went wrong");
    }
  }
}
