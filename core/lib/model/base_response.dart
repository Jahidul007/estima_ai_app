import 'package:dio/dio.dart';

class  BaseResponse {
  late bool isSuccess;
  late String msg;
  DioErrorType? errorType;
  int? responseCode;

  BaseResponse.fromJson(Map<String, dynamic> json);

  BaseResponse.toJson();


  BaseResponse({this.isSuccess = true, this.msg = "", this.responseCode});

}