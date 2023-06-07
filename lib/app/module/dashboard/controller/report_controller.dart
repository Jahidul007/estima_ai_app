import 'package:core/controller/base_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/model/base_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/repository/report_repository.dart';
import 'package:rxdart/rxdart.dart';

class ReportController extends BaseController {
  final _userStoriesReportController = BehaviorSubject<List<ReportItem>>();

  Stream<List<ReportItem>> get userStoriesStream =>
      _userStoriesReportController.stream;

  ReportRepository reportRepository = getIt.get<ReportRepository>();

  getUserStoriesReport() async {
    showLoadingState();
    var response = await reportRepository.getUserStoriesReport(
        exportType: "", userStories: "");
    handleApiCall(response, onSuccess: _handleSuccessResponse);
  }

  _handleSuccessResponse(BaseResponse baseResponse) {
    showSuccessState();

    ReportResponse response = baseResponse as ReportResponse;

    List<ReportItem>? list = response.content;

    _userStoriesReportController.sink.add(list ?? []);
  }
}
