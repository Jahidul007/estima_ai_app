import 'package:core/widget/app_button.dart';
import 'package:core/widget/app_button_small.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:core/widget/text_field_stream.dart';
import 'package:estima_ai_app/app/module/dashboard/controller/user_profile_with_history_controller.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_data_response.dart';
import 'package:flutter/material.dart';

showUserStoriesAndSave(
  BuildContext context,
  ReportResponse response,
  UserProfileWithHistoryController controller,
) {
  final _projectTitleEdition = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        content: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                TextInputStreamField(
                    stream: controller.projectTitle.textStream,
                    errorStream: controller.projectTitle.errorStream,
                    label: "Title*",
                    hint: "Please insert user title",
                    maxLine: 1,
                    onChange: (name) =>
                        controller.projectTitle.updateText(name),
                    textEditingController: _projectTitleEdition),
                customHeight(),
                Text(
                  "${response.reportDataList!.first.title}",
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButtonSmall(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        title: "Close",
                      ),
                    ),
                    customWidth(width: 10),
                    Expanded(
                      child: AppButton(
                        onPressed: () {
                          if (controller.projectTitle.isInputValid()) {
                            Navigator.of(context).pop();
                            controller.saveReportData(response);
                          }
                        },
                        title: "Save",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
