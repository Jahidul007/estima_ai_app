import 'package:core/model/base_response.dart';
import 'package:dio/dio.dart';

class ReportResponse extends BaseResponse {
  int? totalTime;
  List<ReportDataList>? reportDataList;

  ReportResponse({this.totalTime, this.reportDataList});

  ReportResponse.fromJson(Map<String, dynamic> json) {
    totalTime = json['totalTime'];
    if (json['reportDataList'] != null) {
      reportDataList = <ReportDataList>[];
      json['reportDataList'].forEach((v) {
        reportDataList!.add(ReportDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalTime'] = totalTime;
    if (reportDataList != null) {
      data['reportDataList'] = reportDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ReportResponse.responseWithError(DioErrorType? errorType, String message) {
    isSuccess = false;
    errorType = errorType;
    msg = message;
  }
}

class ReportDataList {
  String? title;
  List<BreakdownDataList>? breakdownDataList;
  int? totalTime;

  ReportDataList({this.title, this.breakdownDataList, this.totalTime});

  ReportDataList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['breakdownDataList'] != null) {
      breakdownDataList = <BreakdownDataList>[];
      json['breakdownDataList'].forEach((v) {
        breakdownDataList!.add(BreakdownDataList.fromJson(v));
      });
    }
    totalTime = json['totalTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (breakdownDataList != null) {
      data['breakdownDataList'] =
          breakdownDataList!.map((v) => v.toJson()).toList();
    }
    data['totalTime'] = totalTime;
    return data;
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
