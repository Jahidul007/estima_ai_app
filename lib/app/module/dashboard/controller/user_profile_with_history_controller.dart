import 'package:core/controller/base_controller.dart';
import 'package:core/controller/base_text_field_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/model/base_response.dart';
import 'package:core/utils/show_toast.dart';
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

  final _reportDataController = BehaviorSubject<ReportResponse?>();

  Stream<ReportResponse?> get reportDataStream => _reportDataController.stream;

  late TextFieldController userStoriesController;
  late TextFieldController projectTitle;

  UserProfileWithHistoryController() {
    userStoriesController =
        TextFieldController(validationMessage: "Please insert user stories");
    projectTitle =
        TextFieldController(validationMessage: "Please insert project title");
  }

  UserProfileWithHistoryRepository reportRepository =
      getIt.get<UserProfileWithHistoryRepository>();

  refreshPage() {
    getUserProfileWithHistory();
  }

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
          title: "Order History",
        ),
        UserStoriesWithTitle(
          userStory: "As an administrator, I want to be able to manage user accounts, so that I can control access to the system.",
          title: "User Account Management",
        )
      ],
    );
    handleApiCall(response, onSuccess: _handleReportSuccessResponse);
  }

  _handleReportSuccessResponse(BaseResponse response) async {
    showSuccessState();
    ReportResponse reportDataResponse = response as ReportResponse;
    _reportDataController.sink.add(reportDataResponse);
    //saveReportData(reportDataResponse);
  }

  saveReportData(ReportResponse reportDataResponse) async {
    showLoadingState();
    var response = await reportRepository.generateReportFromJson(
      data: reportDataResponse,
      title: projectTitle.text,
    );
    _handleResponse(response);
  }

  _handleResponse(BaseResponse response) {
    if (response.isSuccess) {
      _handleSaveSuccessResponse(response);
    } else {
      _handleFailedResponse(response);
    }
  }

  _handleSaveSuccessResponse(BaseResponse response) {
    showSuccessState();
    updateRefresh(true);
    _isGenerateSuccess.sink.add(true);
  }

  _handleFailedResponse(BaseResponse response) {
    _isGenerateSuccess.sink.add(false);
    errorMessage = response.msg;
    PageState state = getPageStateFromErrorType(
      response.errorType,
      errorMessage,
    );

    updatePageState(state);
    showToast(errorMessage);
  }

  checkInputIsOkay() {
    return userStoriesController.isInputValid();
  }

  resetAllData() {
    userStoriesController.resetField();
    _reportDataController.add(null);
  }

  @override
  void dispose() {
    userStoriesController.dispose();
    _userStoriesReportController.close();
    super.dispose();
  }
}
