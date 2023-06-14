import 'package:core/model/base_response.dart';
import 'package:dio/dio.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_data_response.dart';

class UserProfileWithHistory extends BaseResponse {
  String? name;
  String? email;
  List<ReportHistories>? reportHistories;
  UserTeamMemberSurvey? userTeamMemberSurvey;

  UserProfileWithHistory(
      {this.name, this.email, this.reportHistories, this.userTeamMemberSurvey});

  UserProfileWithHistory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    if (json['reportHistories'] != null) {
      reportHistories = <ReportHistories>[];
      json['reportHistories'].forEach((v) {
        reportHistories!.add(ReportHistories.fromJson(v));
      });
    }
    userTeamMemberSurvey = json['userTeamMemberSurvey'] != null
        ? UserTeamMemberSurvey.fromJson(json['userTeamMemberSurvey'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    if (reportHistories != null) {
      data['reportHistories'] =
          reportHistories!.map((v) => v.toJson()).toList();
    }
    if (userTeamMemberSurvey != null) {
      data['userTeamMemberSurvey'] = userTeamMemberSurvey!.toJson();
    }
    return data;
  }

  UserProfileWithHistory.responseWithError(
      DioErrorType? errorType, String message) {
    isSuccess = false;
    errorType = errorType;
    msg = message;
    reportHistories = [];
  }
}

class ReportHistories extends BaseResponse {
  int? id;
  ReportResponse? jsonData;
  String? generationTime;
  String? title;
  int? totalTime;

  ReportHistories(
      {this.id,
      this.jsonData,
      this.generationTime,
      this.title,
      this.totalTime});

  ReportHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jsonData =
        json['jsonData'] != null ? ReportResponse.fromJson(json['jsonData']) : null;
    generationTime = json['generationTime'];
    title = json['title'];
    totalTime = json['totalTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (jsonData != null) {
      data['jsonData'] = jsonData!.toJson();
    }
    data['generationTime'] = generationTime;
    data['title'] = title;
    data['totalTime'] = totalTime;
    return data;
  }

  ReportHistories.responseWithError(DioErrorType? errorType, String message) {
    isSuccess = false;
    errorType = errorType;
    msg = message;
  }
}



class UserTeamMemberSurvey {
  int? id;
  int? teamExp;
  int? managerExp;
  int? yearEnd;
  int? length;
  int? effort;
  int? transactions;
  int? entities;
  int? pointsAdjust;
  int? envergure;
  int? pointsNonAdjust;
  int? language;

  UserTeamMemberSurvey(
      {this.id,
      this.teamExp,
      this.managerExp,
      this.yearEnd,
      this.length,
      this.effort,
      this.transactions,
      this.entities,
      this.pointsAdjust,
      this.envergure,
      this.pointsNonAdjust,
      this.language});

  UserTeamMemberSurvey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamExp = json['teamExp'];
    managerExp = json['managerExp'];
    yearEnd = json['yearEnd'];
    length = json['length'];
    effort = json['effort'];
    transactions = json['transactions'];
    entities = json['entities'];
    pointsAdjust = json['pointsAdjust'];
    envergure = json['envergure'];
    pointsNonAdjust = json['pointsNonAdjust'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teamExp'] = teamExp;
    data['managerExp'] = managerExp;
    data['yearEnd'] = yearEnd;
    data['length'] = length;
    data['effort'] = effort;
    data['transactions'] = transactions;
    data['entities'] = entities;
    data['pointsAdjust'] = pointsAdjust;
    data['envergure'] = envergure;
    data['pointsNonAdjust'] = pointsNonAdjust;
    data['language'] = language;
    return data;
  }
}
