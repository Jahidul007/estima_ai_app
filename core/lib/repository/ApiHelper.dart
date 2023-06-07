import 'dart:convert';
import 'dart:io';
import 'package:core/di/setup_core.dart';
import 'package:core/network/error_handlers.dart';
import 'package:core/repository/header_provider_mixin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';

class ApiBaseHelper with HeaderProvider {
  final String _baseUrl;
  final Dio _dio;

  ApiBaseHelper(this._baseUrl, this._dio);

  final logger = getIt.get<Logger>();

  _handleSocketException() {
    debugPrint('No net');
    throw FetchDataException('No Internet connection');
  }

  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameters, String? versionCode}) async {
    dynamic responseJson;

    final _option = await getHeaders(versionCode: versionCode);

    try {
      var response = await _dio.get(
        "$_baseUrl$url",
        options: _option,
        queryParameters: queryParameters,
      );

      return response;
    } on SocketException {
      _handleSocketException();
    }

    return responseJson;
  }

  Future<dynamic> post(String url, dynamic requestBody,
      {Map<String, dynamic>? queryParameters, String? versionCode}) async {
    //var body = json.encode(requestBody);
    dynamic responseJson;
    final _option = await getHeaders(versionCode: versionCode);
    try {
      var response = await _dio.post("$_baseUrl$url",
          options: _option, data: requestBody, queryParameters: queryParameters);

      return response;
    } on SocketException {
      _handleSocketException();
    }

    return responseJson;
  }

  Future<dynamic> put(String url, dynamic requestBody,
      {Map<String, dynamic>? queryParameters,
        bool isDecode = true,
        String? versionCode}) async {
    var body = isDecode ? json.encode(requestBody) : requestBody;
    dynamic responseJson;
    final _option = await getHeaders(versionCode: versionCode);
    try {
      var response = await _dio.put("$_baseUrl$url",
          options: _option, data: body, queryParameters: queryParameters);

      return response;
    } on SocketException {
      _handleSocketException();
    }

    return responseJson;
  }

  Future<dynamic> patch(
      String url, dynamic requestBody, String? versionCode) async {
    var body = json.encode(requestBody);
    dynamic responseJson;
    final _option = await getHeaders(versionCode: versionCode);
    try {
      var response =
      await _dio.patch("$_baseUrl$url", options: _option, data: body);

      responseJson = response;
      return response;
    } on SocketException {
      _handleSocketException();
    }

    return responseJson;
  }

  Future<dynamic> delete(String url,
      {dynamic requestBody, String? versionCode}) async {
    dynamic responseJson;
    final _option = await getHeaders(versionCode: versionCode);
    try {
      var response = await _dio.delete("$_baseUrl$url",
          options: _option, data: jsonEncode(requestBody));

      return response;
    } on SocketException {
      _handleSocketException();
    }

    return responseJson;
  }

  Future<dynamic> fileUpload(String url,
      {dynamic requestBody,
        Map<String, dynamic>? queryParameters,
        String? versionCode}) async {
    dynamic responseJson;
    final _option = await getHeaders(versionCode: versionCode);
    try {
      var response = await _dio.post("$_baseUrl$url",
          options: _option,
          queryParameters: queryParameters,
          data: requestBody);

      return response;
    } on SocketException {
      _handleSocketException();
    }

    return responseJson;
  }

  Future<dynamic> fileDownload(String url,
      {dynamic requestBody,
        Map<String, dynamic>? queryParameters,
        String? versionCode}) async {
    dynamic responseJson;
    final _option = await getHeaders(versionCode: versionCode)
      ..responseType = ResponseType.bytes
      ..contentType = 'multipart/form-data'
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < 500;
      };

    try {
      Response response = await _dio.get(
        url,
        options: _option,
        queryParameters: queryParameters,
      );
      return response;
    } on SocketException {
      _handleSocketException();
    }

    return responseJson;
  }

  Future<dynamic> getLocalJson(String path) async {
    String localJson = await rootBundle.loadString(path);
    Map<String, dynamic> response = await jsonDecode(localJson);
    return response;
  }
}

class FetchDataException extends WalletAppException {
  FetchDataException(String? message)
      : super(message!, "Error During Communication: ");
}

class WalletAppException implements Exception {
  final String _message;
  final String _prefix;

  WalletAppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

Future<T> callApiAndHandleErrors<T>(
    Future<T> Function() apiCall,
    Future<T> Function(String message, DioErrorType? errorType) responseWithError,
    ) async {
  try {
    return await apiCall();
  } on DioError catch (e) {
    String error = handleDioError(e);
    return responseWithError(error, e.type); // this shows error
  } catch (error, stacktrace) {
    logger.d("Exception occurred: $error stackTrace: $stacktrace");
    return responseWithError(error.toString(), null); // this is okay
  }
}
