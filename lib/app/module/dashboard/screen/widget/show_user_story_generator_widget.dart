import 'package:core/utils/show_toast.dart';
import 'package:core/widget/app_button.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:core/widget/text_field_stream.dart';
import 'package:estima_ai_app/app/module/dashboard/controller/user_profile_with_history_controller.dart';
import 'package:flutter/material.dart';

showUserStoryGeneratorWidget(BuildContext context,
    UserProfileWithHistoryController userProfileWithHistoryController) {
  final _userStoriesController = TextEditingController(text: "");
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          insetPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          content: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  TextInputStreamField(
                      stream: userProfileWithHistoryController
                          .userStoriesController.textStream,
                      errorStream: userProfileWithHistoryController
                          .userStoriesController.errorStream,
                      label: "User Stories*",
                      hint: "Please insert user stories",
                      maxLine: 10,
                      onChange: (name) => userProfileWithHistoryController
                          .userStoriesController
                          .updateText(name),
                      textEditingController: _userStoriesController),
                  customHeight(),
                  AppButton(
                    onPressed: () {
                      if (userProfileWithHistoryController.checkInputIsOkay()) {
                        userProfileWithHistoryController.getReportData();
                        Navigator.pop(context);
                      } else {
                        showToast("please insert stories");
                      }
                    },
                    title: "Submit",
                  )
                ],
              ),
            ),
          ),
        );
      });
}
