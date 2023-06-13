import 'package:core/controller/base_controller.dart';
import 'package:core/controller/base_text_field_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/model/base_response.dart';
import 'package:estima_ai_app/app/module/auth/login/data/model/password.dart';
import 'package:estima_ai_app/app/module/auth/registration/data/model/user_registration_response.dart';
import 'package:estima_ai_app/app/module/auth/registration/data/repository/user_registration_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserRegistrationController extends BaseController {
  late TextFieldController firstNameController;
  late TextFieldController lastNameController;
  late TextFieldController emailController;

  final _passwordController = BehaviorSubject<String>();

  Stream<String> get passwordStream => _passwordController.stream;


  final _isRegistrationSuccessController = BehaviorSubject<bool>();
  Stream<bool> get isRegistrationSuccess => _isRegistrationSuccessController.stream;

  //Password visibility
  var _passwordVisibility = false;

  final _passwordVisibilityController = BehaviorSubject<bool>();

  final _passwordErrorController = BehaviorSubject<String?>();

  Stream<String?> get passwordErrorStream => _passwordErrorController.stream;

  Stream<Password> get passwordField => Rx.combineLatest2(
      _passwordController.stream, _passwordVisibilityController.stream,
          (String text, bool visible) {
        return Password(password: text, isVisible: visible);
      }).asBroadcastStream();


  final UseRegistrationRepository _registrationRepository =
      getIt.get<UseRegistrationRepository>();
  final Localization _localization = getIt.get<Localization>();

  UserRegistrationController() {
    _passwordVisibilityController.sink.add(_passwordVisibility);
    firstNameController = TextFieldController(validationMessage: "Enter your first name");
    lastNameController = TextFieldController(validationMessage: "Enter your last name");
    emailController = TextFieldController(validationMessage: "Enter your valid email");
  }

  submitUserRegistration() async {
    showLoadingState();

    UserRegistrationResponse registrationResponse = UserRegistrationResponse(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: _passwordController.value.trim()
    );

    BaseResponse response = await _registrationRepository
        .submitUserRegistration(registrationResponse);
    if (response.isSuccess) {
      _isRegistrationSuccessController.sink.add(true);
      successMessage = "User registration has been successful";
      stateController.add(PageState.SUCCESS);
    } else {
      _isRegistrationSuccessController.sink.add(false);
      errorMessage = response.msg;
      stateController.add(PageState.FAILED);
    }
  }

  updatePassword(String value) {
    _passwordController.sink.add(value);
    _passwordErrorController.add(null);
  }

  updatePasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    _passwordVisibilityController.add(_passwordVisibility);
  }

  checkInputsAreOkay() {
    return firstNameController.isInputValid() &&
        lastNameController.isInputValid() &&
        emailController.isValidEmail() && checkPasswordIsOkay();
  }

  checkPasswordIsOkay(){
    bool isOkay = true;

    if (_passwordController.hasValue &&
        _passwordController.value.trim().isNotEmpty) {
      if (_passwordController.value.length >= 4) {
        _passwordController.value;
      } else {
        _passwordErrorController.sink
            .add("${_localization.commonPasswordRules}");
        isOkay = false;
      }
    } else {
      _passwordErrorController.sink.add("${_localization.commonPasswordRules}");
      isOkay = false;
    }
    return isOkay;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
