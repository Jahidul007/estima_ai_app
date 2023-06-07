import 'package:core/model/base_response.dart';
import 'package:dio/dio.dart';

class EmptyResponse extends BaseResponse{

  EmptyResponse();

  @override
  factory EmptyResponse.responseWithError(String message, DioErrorType? errorType)
  {
    return EmptyResponse()
      ..isSuccess = false
      ..msg = message
      ..errorType = errorType;
  }
}