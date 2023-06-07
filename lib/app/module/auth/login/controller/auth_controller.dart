import 'package:core/controller/base_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/model/auth/data/model/access_token_response.dart';
import 'package:core/model/base_response.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:core/utils/regex_const.dart';
import 'package:core/utils/show_toast.dart';
import 'package:core/utils/validator/email_validator.dart';
import 'package:estima_ai_app/app/module/auth/login/data/model/password.dart';
import 'package:estima_ai_app/app/module/auth/login/data/repository/access_token_repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthController extends BaseController with EmailValidator {
  final _emailController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream;

  Stream<String> get email => _emailController.stream;

  final _emailErrorController = BehaviorSubject<String?>();

  Stream<String?> get emailErrorStream => _emailErrorController.stream;

  final _passwordController = BehaviorSubject<String>();

  Stream<String> get passwordStream => _passwordController.stream;

  Stream<String> get _password => _passwordController.stream;

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

  final _tokenGenerateSuccessController = BehaviorSubject<bool>();

  Stream<bool> get isTokenGenerateSuccess =>
      _tokenGenerateSuccessController.stream;

  final PreferenceManager _preferenceManager = getIt.get<PreferenceManager>();
  final AccessTokenRepository _authRepository =
      getIt.get<AccessTokenRepository>();

  final Localization _localization = getIt.get<Localization>();

  AuthController() {
    _passwordVisibilityController.sink.add(_passwordVisibility);
  }

  updateEmail(String value) {
    _emailController.sink.add(value);
    _emailErrorController.add(null);
  }

  updatePassword(String value) {
    _passwordController.sink.add(value);
    _passwordErrorController.add(null);
  }

  updatePasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    _passwordVisibilityController.add(_passwordVisibility);
  }

  getAccessTokenResponse() async {
    showLoadingState();
    String email = _emailController.value.trim();
    String password = _passwordController.value.trim();
    var response =
        await _authRepository.getAccessTokenResponse(email, password);

    _handleApiResponse(response);
  }

  _handleApiResponse(BaseResponse response) async {
    if (response.isSuccess) {
      showSuccessState();
      await _preferenceManager
          .saveAccessTokenInfo(response as AccessTokenResponse);
      _tokenGenerateSuccessController.sink.add(true);
    } else {
      resetPageState();
      _tokenGenerateSuccessController.sink.add(false);
      showToast(response.msg);
    }
  }

  Stream<bool> get isInputValid =>
      Rx.combineLatest2(email, _password, (eValue, pValue) {
        if (eValue != null &&
            eValue == _emailController.value &&
            pValue == _passwordController.value) {
          return true;
        }
        return false;
      }).asBroadcastStream();

  inputError() {
    errorMessage = "${_localization.commonCheckCredentials}";
    stateController.add(PageState.FAILED);
  }

  checkInputsAreOkay() {
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

    if (_emailController.hasValue && _emailController.value.trim().isNotEmpty) {
      if (_emailController.value.contains("@")) {
        if (emailRegex.hasMatch(_emailController.value.trim())) {
          _emailController.value;
        } else {
          _emailErrorController.sink
              .add("${_localization.commonEmailValidMessage}");
          isOkay = false;
        }
      }
    } else {
      _emailErrorController.sink.add("${_localization.commonValidUserMessage}");
      isOkay = false;
    }

    return isOkay;
  }

  @override
  void dispose() {
    _emailController.close();
    _emailErrorController.close();
    _passwordController.close();
    _passwordErrorController.close();
    _passwordVisibilityController.close();
    _tokenGenerateSuccessController.close();
    super.dispose();
  }
}
