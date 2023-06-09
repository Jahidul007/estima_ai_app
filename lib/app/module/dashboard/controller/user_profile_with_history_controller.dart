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

  late TextFieldController userStoriesTitleController;
  late TextFieldController userStoriesController;
  late TextFieldController projectTitle;

  late TextFieldController userStoriesTitle2Controller;
  late TextFieldController userStories2Controller;

  UserProfileWithHistoryController() {
    userStoriesTitleController = TextFieldController(
        validationMessage: "Please insert user stories title");
    userStoriesController =
        TextFieldController(validationMessage: "Please insert user stories");

    userStoriesTitle2Controller = TextFieldController(
        validationMessage: "Please insert user stories title");
    userStories2Controller =
        TextFieldController(validationMessage: "Please insert user stories");
    projectTitle =
        TextFieldController(validationMessage: "Please insert project title");
  }

  UserProfileWithHistoryRepository userProfileRepository =
      getIt.get<UserProfileWithHistoryRepository>();

  refreshPage() {
    getUserProfileWithHistory();
  }

  refreshPageForDetails({required String id}) {
    getDetailsData(id: id);
  }
  getUserProfileWithHistory() async {
    showLoadingState();
    var response = await userProfileRepository.getUserProfileWithHistory(
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

    List<UserStoriesWithTitle> listOfUserStory = [];
    listOfUserStory.add(
      UserStoriesWithTitle(
        userStory: userStoriesController.text,
        title: userStoriesTitleController.text,
      ),
    );

    if (_addMoreController.value == true) {
      listOfUserStory.add(
        UserStoriesWithTitle(
          userStory: userStories2Controller.text,
          title: userStoriesTitle2Controller.text,
        ),
      );
    }

    var response = await userProfileRepository.getReportData(data: listOfUserStory);
    handleApiCall(response, onSuccess: _handleReportSuccessResponse);
  }

  _handleReportSuccessResponse(BaseResponse response) async {
    showSuccessState();
    ReportResponse reportDataResponse = response as ReportResponse;
    _reportDataController.sink.add(reportDataResponse);
    //saveReportData(reportDataResponse);
  }

  saveReportData(ReportResponse reportDataResponse, {String? id}) async {
    showLoadingState();
    var response = await userProfileRepository.generateReportFromJson(
      data: reportDataResponse,
      title: projectTitle.text,
      id: id,
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
    bool isOkay = false;

    isOkay = userStoriesTitleController.isInputValid() &&
        userStoriesController.isInputValid();

    if (_addMoreController.hasValue && _addMoreController.value == true) {
      isOkay = userStoriesTitle2Controller.isInputValid() &&
          userStories2Controller.isInputValid();
    }

    return isOkay;
  }

  resetAllData() {
    projectTitle.resetField();
    userStoriesTitleController.resetField();
     userStoriesController.resetField();
     _reportDataController.add(null);
     userStoriesTitle2Controller.resetField();
     userStories2Controller.resetField();
    _addMoreController.add(false);
  }

  final _addMoreController = BehaviorSubject<bool?>.seeded(false);

  Stream<bool?> get addMoreStream => _addMoreController.stream;

  updateAddMore(bool value) {
    _addMoreController.sink.add(value);
  }

  final _reportDetailsController = BehaviorSubject<ReportHistories>();
  Stream<ReportHistories> get reportDetailsStream => _reportDetailsController.stream;
  
  getDetailsData({required String id}) async{
    showLoadingState();
    var response = await userProfileRepository.getReportDetails(id: id);
    handleApiCall(response, onSuccess: _handleDetailsSuccessResponse);
  }

  _handleDetailsSuccessResponse(BaseResponse response){
    showSuccessState();

    ReportHistories reportHistories = response as ReportHistories;
    _reportDetailsController.sink.add(reportHistories);

  }

  @override
  void dispose() {
    userStoriesController.dispose();
    _userStoriesReportController.close();
    _addMoreController.close();
    super.dispose();
  }
}
