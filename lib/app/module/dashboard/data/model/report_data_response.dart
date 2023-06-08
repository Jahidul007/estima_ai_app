import 'package:core/model/base_response.dart';
import 'package:dio/dio.dart';

class ReportResponse extends BaseResponse{
  List<ReportDataResponse>? data;

  ReportResponse(this.data);

  ReportResponse.fromJsonMap(dynamic data):
        data = List<ReportDataResponse>.from(data.map((vt) => ReportDataResponse.fromJson(vt)));

  ReportResponse.responseWithError(DioErrorType? errorType, String message) {
    isSuccess = false;
    errorType = errorType;
    msg = message;
  }
}

class ReportDataResponse extends BaseResponse{
  String? title;
  List<BreakdownDataList>? breakdownDataList;

  ReportDataResponse({this.title, this.breakdownDataList});

  ReportDataResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['breakdownDataList'] != null) {
      breakdownDataList = <BreakdownDataList>[];
      json['breakdownDataList'].forEach((v) {
        breakdownDataList!.add(BreakdownDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (breakdownDataList != null) {
      data['breakdownDataList'] =
          breakdownDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ReportDataResponse.responseWithError(DioErrorType? errorType, String message) {
    isSuccess = false;
    errorType = errorType;
    msg = message;
  }
}

class BreakdownDataList {
  String? featureTitle;
  String? featureIntent;
  String? subtasksOfFeatures;
  String? implementationTime;
  String? complexity;
  String? kloc;

  BreakdownDataList(
      {this.featureTitle,
        this.featureIntent,
        this.subtasksOfFeatures,
        this.implementationTime,
        this.complexity,
        this.kloc});

  BreakdownDataList.fromJson(Map<String, dynamic> json) {
    featureTitle = json['featureTitle'];
    featureIntent = json['featureIntent'];
    subtasksOfFeatures = json['subtasksOfFeatures'];
    implementationTime = json['implementationTime'];
    complexity = json['complexity'];
    kloc = json['kloc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['featureTitle'] = featureTitle;
    data['featureIntent'] = featureIntent;
    data['subtasksOfFeatures'] = subtasksOfFeatures;
    data['implementationTime'] = implementationTime;
    data['complexity'] = complexity;
    data['kloc'] = kloc;
    return data;
  }
}
