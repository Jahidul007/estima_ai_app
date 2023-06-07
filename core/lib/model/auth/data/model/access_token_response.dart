import 'package:core/model/base_response.dart';

class AccessTokenResponse extends BaseResponse {
  String? accessToken;
  String? scope;
  String? tokenType;
  int? expiresIn;

  AccessTokenResponse(
      {this.accessToken, this.scope, this.tokenType, this.expiresIn});

  AccessTokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    scope = json['scope'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['scope'] = scope;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    return data;
  }

  AccessTokenResponse.responseWithError(String message) {
    accessToken = null;
    tokenType = null;
    expiresIn = null;
    isSuccess = false;
    msg = message;
    errorType = errorType;
  }
}
