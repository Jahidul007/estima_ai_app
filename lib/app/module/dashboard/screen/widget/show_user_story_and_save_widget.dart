import 'package:core/widget/app_button.dart';
import 'package:core/widget/app_button_small.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:estima_ai_app/app/module/dashboard/controller/user_profile_with_history_controller.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_data_response.dart';
import 'package:flutter/material.dart';
import 'report_item_widget.dart';

showUserStoriesAndSave(BuildContext context, ReportResponse response,
    UserProfileWithHistoryController controller,
    {String? id, ReportResponse? reportResponse, String? title}) {
  //controller.projectTitle.updateText("$title");

  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
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
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: response.reportDataList!.length,
                    itemBuilder: (context, ind) {
                      return ReportItemWidget(
                        reportDataList: response.reportDataList![ind],
                      );
                    },
                    separatorBuilder: (context, index) => customHeight(),
                  ),
                  customHeight(),
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
                            Navigator.of(context).pop();
                            if (reportResponse != null) {
                              controller.saveReportData(reportResponse, id: id);
                            } else {
                              controller.saveReportData(response, id: id);
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
      });
}
