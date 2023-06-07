import 'package:core/model/base_response.dart';

class AccessTokenRequestResponse extends BaseResponse{
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? accessToken;
  String? refreshToken;

  AccessTokenRequestResponse(
      {this.username,
        this.firstName,
        this.lastName,
        this.email,
        this.accessToken,
        this.refreshToken});

  AccessTokenRequestResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }

  AccessTokenRequestResponse.responseWithError(String message){
    accessToken = null;
    isSuccess = false;
    msg = message;
    errorType = errorType;
  }
}
