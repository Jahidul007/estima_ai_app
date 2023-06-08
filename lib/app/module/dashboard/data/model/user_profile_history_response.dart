import 'package:core/model/base_response.dart';
import 'package:dio/dio.dart';

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

  UserProfileWithHistory.responseWithError(DioErrorType? errorType, String message) {
    isSuccess = false;
    errorType = errorType;
    msg = message;
  }
}

class ReportHistories{
  int? id;
  List<JsonData>? jsonData;
  String? generationTime;
  String? title;

  ReportHistories({this.id, this.jsonData, this.generationTime, this.title});

  ReportHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['jsonData'] != null) {
      jsonData = <JsonData>[];
      json['jsonData'].forEach((v) {
        jsonData!.add(JsonData.fromJson(v));
      });
    }
    generationTime = json['generationTime'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (jsonData != null) {
      data['jsonData'] = jsonData!.map((v) => v.toJson()).toList();
    }
    data['generationTime'] = generationTime;
    data['title'] = title;
    return data;
  }
}

class JsonData {
  String? featureTitle;
  String? featureIntent;
  String? subtasksOfFeatures;
  String? implementationTime;
  String? complexity;
  String? kloc;

  JsonData(
      {this.featureTitle,
        this.featureIntent,
        this.subtasksOfFeatures,
        this.implementationTime,
        this.complexity,
        this.kloc});

  JsonData.fromJson(Map<String, dynamic> json) {
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
