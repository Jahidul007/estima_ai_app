import 'package:core/screen/base_page_screen.dart';
import 'package:core/screen/base_screen.dart';
import 'package:core/utils/constants.dart';
import 'package:core/widget/custom_input_with_error.dart';
import 'package:estima_ai_app/app/module/auth/login/controller/auth_controller.dart';
import 'package:estima_ai_app/app/module/auth/login/data/model/password.dart';
import 'package:estima_ai_app/app/route/estima_app_route.dart';
import 'package:flutter/material.dart';

class LoginScreen extends BasePageScreen {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreen<LoginScreen> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _authController.isLoginStream.listen((event) {
      if (event) {
        Navigator.pushNamedAndRemoveUntil(
            context, EstimaAppRoute.dashboardScreen, (route) => false);
      }
    });
  }

  @override
  PreferredSizeWidget? appBar() {
    return null;
  }

  @override
  bindControllers() {
    addControllers(_authController);
  }

  getTitleTag() {
    return const Center(
      child: Text("Welcome to EstimaAI"),
    );
  }

  @override
  Widget body() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'EstimaAI',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _loginEmail(context),
            const SizedBox(height: 16),
            _loginPassword(context),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_authController.checkInputsAreOkay()) {
                  await _authController.getAccessTokenResponse();
                }
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: primaryColor
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, EstimaAppRoute.registrationScreen);
              },
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginEmail(BuildContext context) {
    var _emailTextController = TextEditingController(text: "");

    return CustomInputWithError(
        inputWidget: StreamBuilder<String>(
          stream: _authController.email,
          initialData: "",
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _emailTextController.value =
                  _emailTextController.value.copyWith(text: snapshot.data);
            }
            return TextFormField(
              controller: _emailTextController,
              onChanged: _authController.updateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                border: const OutlineInputBorder(),
                labelText: "${localization.loginUserNameStar}",
                hintText: "${localization.loginUserNameHint}",
                labelStyle: labelText,
                hintStyle: body2regular,
              ),
            );
          },
        ),
        errorStream: _authController.emailErrorStream);
  }

  Widget _loginPassword(BuildContext context) {
    var _passwordTextController = TextEditingController(text: "");

    return CustomInputWithError(
      inputWidget: StreamBuilder<Password>(
        stream: _authController.passwordField,
        initialData: Password(password: "", isVisible: false),
        builder: (context, AsyncSnapshot<Password> snapshot) {
          if (snapshot.hasData) {
            _passwordTextController.value = _passwordTextController.value
                .copyWith(text: snapshot.data?.password);
          }
          return TextFormField(
            controller: _passwordTextController,
            obscureText: !snapshot.data!.isVisible!,
            onChanged: _authController.updatePassword,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: const OutlineInputBorder(),
              labelText: "${localization.loginPasswordStar}",
              labelStyle: labelText,
              hintText: "${localization.commonPasswordHint}",
              hintStyle: body2regular,
              errorMaxLines: 3,
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  snapshot.data!.isVisible!
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                onPressed: () {
                  _authController.updatePasswordVisibility();
                },
              ),
            ),
            onFieldSubmitted: (vale) {
              if (_authController.checkInputsAreOkay()) {
                _authController.getAccessTokenResponse();
              }
            },
          );
        },
      ),
      errorStream: _authController.passwordErrorStream,
    );
  }

  @override
  Widget? floatingActionButton() {
    return null;
  }

  @override
  void onClickBackButton() {}

  @override
  Color? pageBackgroundColor() {
    return null;
  }
}
