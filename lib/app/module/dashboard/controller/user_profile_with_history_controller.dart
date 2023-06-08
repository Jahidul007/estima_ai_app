import 'package:core/controller/base_controller.dart';
import 'package:core/controller/base_text_field_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/model/base_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_data_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_profile_history_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_stories_with_title_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/repository/user_profile_with_history_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileWithHistoryController extends BaseController {
  final _userStoriesReportController =
      BehaviorSubject<UserProfileWithHistory>();

  Stream<UserProfileWithHistory> get userStoriesStream =>
      _userStoriesReportController.stream;

  final _reportDataController = BehaviorSubject<ReportResponse>();

  Stream<ReportResponse> get reportDataStream =>
      _reportDataController.stream;

  late TextFieldController userStoriesController;

  UserProfileWithHistoryController() {
    userStoriesController =
        TextFieldController(validationMessage: "Please insert user stories");
  }

  UserProfileWithHistoryRepository reportRepository =
      getIt.get<UserProfileWithHistoryRepository>();

  getUserProfileWithHistory() async {
    showLoadingState();
    var response = await reportRepository.getUserProfileWithHistory(
        exportType: "", userStories: "");
    handleApiCall(response, onSuccess: _handleSuccessResponse);
  }

  _handleSuccessResponse(BaseResponse baseResponse) {
    showSuccessState();

    UserProfileWithHistory response = baseResponse as UserProfileWithHistory;

    _userStoriesReportController.sink.add(response);
  }

  final _isGenerateSuccess = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isGenerateStream => _isGenerateSuccess.stream;

  getReportData() async {
    showLoadingState();
    var response = await reportRepository.getReportData(
      data: [
        UserStoriesWithTitle(
          userStory: userStoriesController.text,
          title: "User stories",
        )
      ],
    );
    handleApiCall(response, onSuccess: _handleReportSuccessResponse);

  }

  _handleReportSuccessResponse(BaseResponse response)async{
    showSuccessState();
    ReportResponse reportDataResponse =  response as ReportResponse;
     await reportRepository.generateReportFromJson(data: [reportDataResponse.data![0]]);
    _isGenerateSuccess.sink.add(true);
    _reportDataController.sink.add(reportDataResponse);
  }

  checkInputIsOkay() {
    return userStoriesController.isInputValid();
  }

  @override
  void dispose() {
    userStoriesController.dispose();
    _userStoriesReportController.close();
    super.dispose();
  }
}
