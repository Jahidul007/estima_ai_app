import 'package:core/utils/constants.dart';
import 'package:core/utils/show_toast.dart';
import 'package:core/widget/app_button.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:core/widget/text_field_stream.dart';
import 'package:core/widget/title_with_background.dart';
import 'package:estima_ai_app/app/module/dashboard/controller/user_profile_with_history_controller.dart';
import 'package:flutter/material.dart';

showUserStoryGeneratorWidget(BuildContext context,
    UserProfileWithHistoryController userProfileWithHistoryController,
    {String? id, bool isCreate = true}) {
  final _userStoriesTitleController = TextEditingController(text: "");
  final _userStoriesController = TextEditingController(text: "");

  final _userStoriesTitle2Controller = TextEditingController(text: "");
  final _userStories2Controller = TextEditingController(text: "");
  final _projectTitleEdition = TextEditingController(text: "");
  userProfileWithHistoryController.resetAllData();
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
                  customHeight(),
                  if (isCreate)
                    TextInputStreamField(
                        stream: userProfileWithHistoryController
                            .projectTitle.textStream,
                        errorStream: userProfileWithHistoryController
                            .projectTitle.errorStream,
                        label: "Project Name*",
                        hint: "Please give a project name",
                        maxLine: 1,
                        onChange: (name) => userProfileWithHistoryController
                            .projectTitle
                            .updateText(name),
                        textEditingController: _projectTitleEdition),
                  if (isCreate) customHeight(),
                  const TitleWithBackground(title: "User Stories 1"),
                  customHeight(),
                  TextInputStreamField(
                    stream: userProfileWithHistoryController
                        .userStoriesTitleController.textStream,
                    errorStream: userProfileWithHistoryController
                        .userStoriesTitleController.errorStream,
                    label: "Title*",
                    hint: "Please insert user stories title",
                    maxLine: 1,
                    onChange: (name) => userProfileWithHistoryController
                        .userStoriesTitleController
                        .updateText(name),
                    textEditingController: _userStoriesTitleController,
                  ),
                  customHeight(),
                  TextInputStreamField(
                      stream: userProfileWithHistoryController
                          .userStoriesController.textStream,
                      errorStream: userProfileWithHistoryController
                          .userStoriesController.errorStream,
                      label: "Stories*",
                      hint: "Please insert user stories",
                      maxLine: 3,
                      onChange: (name) => userProfileWithHistoryController
                          .userStoriesController
                          .updateText(name),
                      textEditingController: _userStoriesController),
                  customHeight(),
                  StreamBuilder<bool?>(
                      stream: userProfileWithHistoryController.addMoreStream,
                      builder: (context, snapshot) {
                        bool addMore = false;
                        if (snapshot.hasData) {
                          addMore = snapshot.data!;
                        }
                        return Column(
                          children: [
                            if (!addMore)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customWidth(),
                                  InkWell(
                                    onTap: () {
                                      userProfileWithHistoryController
                                          .updateAddMore(true);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: primaryColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2),
                                        child: Text("Add more"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            customHeight(),
                            if (addMore)
                              Column(
                                children: [
                                  customHeight(),
                                  const TitleWithBackground(
                                      title: "User Stories 2"),
                                  customHeight(),
                                  TextInputStreamField(
                                    stream: userProfileWithHistoryController
                                        .userStoriesTitle2Controller.textStream,
                                    errorStream:
                                        userProfileWithHistoryController
                                            .userStoriesTitle2Controller
                                            .errorStream,
                                    label: "Title*",
                                    hint: "Please insert user stories title 2",
                                    maxLine: 1,
                                    onChange: (name) =>
                                        userProfileWithHistoryController
                                            .userStoriesTitle2Controller
                                            .updateText(name),
                                    textEditingController:
                                        _userStoriesTitle2Controller,
                                  ),
                                  customHeight(),
                                  TextInputStreamField(
                                      stream: userProfileWithHistoryController
                                          .userStories2Controller.textStream,
                                      errorStream:
                                          userProfileWithHistoryController
                                              .userStories2Controller
                                              .errorStream,
                                      label: "Stories*",
                                      hint: "Please insert user stories 2",
                                      maxLine: 5,
                                      onChange: (name) =>
                                          userProfileWithHistoryController
                                              .userStories2Controller
                                              .updateText(name),
                                      textEditingController:
                                          _userStories2Controller),
                                  customHeight(),
                                ],
                              )
                          ],
                        );
                      }),
                  AppButton(
                    onPressed: () {
                      if (isCreate) {
                        if (userProfileWithHistoryController.projectTitle
                                .isInputValid() &&
                            userProfileWithHistoryController
                                .checkInputIsOkay()) {
                          userProfileWithHistoryController.getReportData();
                          Navigator.pop(context);
                        } else {
                          showToast("please insert stories");
                        }
                      } else {
                        if (userProfileWithHistoryController
                            .checkInputIsOkay()) {
                          userProfileWithHistoryController.getReportData();
                          Navigator.pop(context);
                        }
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
