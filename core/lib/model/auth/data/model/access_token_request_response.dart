import 'package:core/model/base_response.dart';

class AccessTokenRequestResponse extends BaseResponse{
  String? jwt;

  AccessTokenRequestResponse({this.jwt});

  AccessTokenRequestResponse.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jwt'] = jwt;
    return data;
  }

  AccessTokenRequestResponse.responseWithError(String message) {
    jwt = null;
    isSuccess = false;
    msg = message;
    errorType = errorType;
  }
}
