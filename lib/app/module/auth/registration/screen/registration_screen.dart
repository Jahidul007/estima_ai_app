import 'package:core/screen/base_page_screen.dart';
import 'package:core/screen/base_screen.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/show_toast.dart';
import 'package:core/widget/custom_input_with_error.dart';
import 'package:core/widget/text_field_stream.dart';
import 'package:estima_ai_app/app/module/auth/login/data/model/password.dart';
import 'package:estima_ai_app/app/module/auth/registration/controller/user_registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:core/widget/focusable_widget.dart';

class RegistrationScreen extends BasePageScreen {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends BaseScreen<RegistrationScreen> {
  final UserRegistrationController _registrationController =
      UserRegistrationController();

  @override
  void initState() {
    super.initState();
    _registrationController.isRegistrationSuccess.listen((event) {
      if(event== true){

        showToast(_registrationController.successMessage);
        Navigator.of(context).pop();
      }else{
        showToast(_registrationController.errorMessage);
      }
    });
  }

  @override
  PreferredSizeWidget? appBar() {
    return null;
  }

  @override
  bindControllers() {
    addControllers(_registrationController);
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
            _getFirstNameField(),
            const SizedBox(height: 16),
            _getLastNameField(),
            const SizedBox(height: 16),
            _getEmailField(),
            const SizedBox(height: 16),
            _loginPassword(context),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_registrationController.checkInputsAreOkay()) {
                  await _registrationController.submitUserRegistration();
                }
              },
              child: const Text('Registration'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _firstNameController = TextEditingController(text: "");
  final nameKey = GlobalKey();

  Widget _getFirstNameField() {
    return FocusableWidget(
        _registrationController.firstNameController.textFocusStream,
        TextInputStreamField(
            stream: _registrationController.firstNameController.textStream,
            errorStream:
                _registrationController.firstNameController.errorStream,
            label: "${localization.registrationFirstNameStar}",
            hint: "${localization.registrationFirstNameHint}",
            onChange: (name) =>
                _registrationController.firstNameController.updateText(name),
            textEditingController: _firstNameController),
        nameKey,
        "name");
  }

  final _lastNameController = TextEditingController(text: "");

  Widget _getLastNameField() {
    return TextInputStreamField(
        stream: _registrationController.lastNameController.textStream,
        errorStream: _registrationController.lastNameController.errorStream,
        label: "${localization.registrationLastName}*",
        hint: "${localization.registrationLastNameHint}",
        onChange: (name) =>
            _registrationController.lastNameController.updateText(name),
        textEditingController: _lastNameController);
  }

  final _emailController = TextEditingController(text: "");
  final emailKey = GlobalKey();

  Widget _getEmailField() {
    return FocusableWidget(
        _registrationController.emailController.textFocusStream,
        TextInputStreamField(
            stream: _registrationController.emailController.textStream,
            errorStream: _registrationController.emailController.errorStream,
            label: "${localization.registrationEmailStar}",
            hint: "${localization.registrationEmailValidMsg}",
            onChange: (name) =>
                _registrationController.emailController.updateText(name),
            textEditingController: _emailController),
        emailKey,
        "email");
  }

  Widget _loginPassword(BuildContext context) {
    var _passwordTextController = TextEditingController(text: "");

    return CustomInputWithError(
      inputWidget: StreamBuilder<Password>(
        stream: _registrationController.passwordField,
        initialData: Password(password: "", isVisible: false),
        builder: (context, AsyncSnapshot<Password> snapshot) {
          if (snapshot.hasData) {
            _passwordTextController.value = _passwordTextController.value
                .copyWith(text: snapshot.data?.password);
          }
          return TextFormField(
            controller: _passwordTextController,
            obscureText: !snapshot.data!.isVisible!,
            onChanged: _registrationController.updatePassword,
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
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  _registrationController.updatePasswordVisibility();
                },
              ),
            ),
            onFieldSubmitted: (vale) {
              if (_registrationController.checkInputsAreOkay()) {
                _registrationController.submitUserRegistration();
              }
            },
          );
        },
      ),
      errorStream: _registrationController.passwordErrorStream,
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
