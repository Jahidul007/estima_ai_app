import 'package:core/model/base_response.dart';

class UserRegistrationResponse extends BaseResponse{
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  UserRegistrationResponse(
      {this.firstName, this.lastName, this.email, this.password});

  UserRegistrationResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
