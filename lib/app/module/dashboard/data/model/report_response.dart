import 'package:core/model/base_response.dart';
import 'package:dio/dio.dart';

class ReportResponse extends BaseResponse {
  List<ReportItem>? content;

  ReportResponse.fromJson(Map<String, dynamic> json) {
    {
      content = List<ReportItem>.from(
          json["content"].map((x) => ReportItem.fromJson(x)));
    }
  }

  ReportResponse.responseWithError(DioErrorType? errorType, String message) {
    isSuccess = false;
    errorType = errorType;
    msg = message;
    content = null;
  }
}

class ReportItem {
  String? userStories;
  String? title;

  ReportItem({this.userStories, this.title});

  ReportItem.fromJson(Map<String, dynamic> json) {
    userStories = json['userStories'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userStories'] = userStories;
    data['title'] = title;
    return data;
  }
}
