import 'dart:convert';

import 'package:core/model/base_response.dart';
import 'package:core/repository/ApiHelper.dart';
import 'package:core/repository/base_repository.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_data_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_profile_history_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_stories_with_title_response.dart';

class UserProfileWithHistoryRepository extends BaseRepository {
  Future<UserProfileWithHistory> getUserProfileWithHistory(
      {String? exportType, String? userStories}) async {
    return callApiAndHandleErrors(
      () async {
        var response = await apiHelper.get(
          "/user/profile-report-histories",
        );
        return UserProfileWithHistory.fromJson(response.data)..isSuccess = true;
      },
      (message, errorType) async =>
          UserProfileWithHistory.responseWithError(errorType, message),
    );
  }

  Future<ReportResponse> getReportData(
      {required List<UserStoriesWithTitle> data}) async {
    return callApiAndHandleErrors(
      () async {
        var response = await apiHelper.post(
            "/process-user-stories", jsonEncode([data[0].toJson(),data[1].toJson() ]));
        return ReportResponse.fromJson(response.data)..isSuccess = true;
      },
      (message, errorType) async =>
          ReportResponse.responseWithError(errorType, message),
    );
  }

  Future<BaseResponse> generateReportFromJson(
      {required ReportResponse data,required String title}) async {
    var param = {
      "title": title,
    };
    return callApiAndHandleErrors(
      () async {
        var response = await apiHelper.post(
            "/user/save-processed-stories", data.toJson(), queryParameters: param);
        return BaseResponse.fromJson(response.data)..isSuccess = true;
      },
      (message, errorType) async =>
          BaseResponse(msg: message),
    );
  }
}
