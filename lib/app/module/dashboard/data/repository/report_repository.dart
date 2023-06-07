import 'package:core/repository/ApiHelper.dart';
import 'package:core/repository/base_repository.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_response.dart';

class ReportRepository extends BaseRepository {
  Future<ReportResponse> getUserStoriesReport(
      {String? exportType, String? userStories}) async {
    var params = {
      "exportType": exportType,
      "userStories": userStories,
    };
    return callApiAndHandleErrors(
      () async {
        var response = await apiHelper.get(
          "/api/report",
          queryParameters: params,
        );
        return ReportResponse.fromJson(response.data)..isSuccess = true;
      },
      (message, errorType) async =>
          ReportResponse.responseWithError(errorType, message),
    );
  }
}
