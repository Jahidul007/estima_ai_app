import 'package:core/model/user/user_response.dart';
import 'package:core/model/base_response.dart';

class UserWithAuth extends BaseResponse {
  late UserResponse userInfo;
  late List<String> authorities;

  bool isSuccess = true;
  String msg = "";

  UserWithAuth.fromJsonMap(Map<String, dynamic> json) {
    authorities = json['authorities'].cast<String>();
    userInfo = (json['userinfo'] != null
        ? UserResponse.fromJsonMap(json['userinfo'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authorities'] = authorities;
    data['userinfo'] = userInfo.toJson();
    return data;
  }

  UserWithAuth.withError(String message) {
    isSuccess = false;
    msg = message;
    errorType = errorType;
  }
}
