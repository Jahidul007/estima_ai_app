import 'package:core/screen/base_page_screen.dart';
import 'package:core/screen/base_screen.dart';
import 'package:core/utils/constants.dart';
import 'package:core/widget/app_button.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:estima_ai_app/app/module/dashboard/controller/user_profile_with_history_controller.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/report_data_response.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_profile_history_response.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/report_generation/pdf_generator_widget.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/widget/feature_breakdown_widget.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/widget/show_user_story_and_save_widget.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/widget/show_user_story_generator_widget.dart';
import 'package:flutter/material.dart';

class UserStoriesDetailsScreen extends BasePageScreen {
  final ReportHistories reportHistories;

  const UserStoriesDetailsScreen({Key? key, required this.reportHistories})
      : super(key: key);

  @override
  State<UserStoriesDetailsScreen> createState() =>
      _UserStoriesDetailsScreenState();
}

class _UserStoriesDetailsScreenState
    extends BaseScreen<UserStoriesDetailsScreen> {
  final UserProfileWithHistoryController controller =
      UserProfileWithHistoryController();

  ReportHistories? reportHistories;
  List<ReportDataList>? re;

  @override
  void initState() {
    super.initState();
    controller.getDetailsData(id: "${widget.reportHistories.id}");

    controller.reportDataStream.listen(
      (event) {
        if (event != null) {
          widget.reportHistories.jsonData?.reportDataList
              ?.addAll(event.reportDataList!);
          //event.reportDataList?.addAll(widget.reportHistories.jsonData!.reportDataList!);
          showUserStoriesAndSave(
            context,
            event,
            controller,
            id: "${widget.reportHistories.id}",
            reportResponse: widget.reportHistories.jsonData,
            title: widget.reportHistories.title,
          );
        }
      },
    );
  }

  @override
  void onPageRefresh() {
    super.onPageRefresh();
    controller.refreshPageForDetails(id: "${widget.reportHistories.id}");
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      title: Text(
        "${widget.reportHistories.title}",
        style: body2regular.copyWith(fontSize: 24, color: Colors.white),
      ),
    );
  }

  @override
  bindControllers() {
    addControllers(controller);
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: StreamBuilder(
          stream: controller.reportDetailsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              reportHistories = snapshot.data!;
              if (reportHistories?.jsonData == null) {
                return const Center(
                  child: Text(
                    "There is no data",
                    style: body2regular,
                  ),
                );
              }
            }
            if (reportHistories != null) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Total Estimated Time: ${reportHistories?.jsonData?.totalTime} Hours",
                          style: body2regular.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FractionallySizedBox(
                            widthFactor: .35,
                            child: AppButton(
                              onPressed: () {
                                showUserStoryGeneratorWidget(
                                    context, controller,
                                    isCreate: false);
                              },
                              title: "Add user story",
                              height: 56,
                              showIcon: true,
                              borderRadius: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  customHeight(),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        reportHistories!.jsonData!.reportDataList!.length,
                    itemBuilder: (context, ind) {
                      return FeatureBreakDownWidget(
                        reportDataList:
                            reportHistories!.jsonData!.reportDataList![ind],
                      );
                    },
                    separatorBuilder: (context, index) => customHeight(),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "There is no data",
                  style: body2regular,
                ),
              );
            }
          }),
    );
  }

  @override
  Widget? floatingActionButton() {
    return InkWell(
      onTap: () async {
        await PDFDownloadGenerator(widget.reportHistories, ).generateInvoice();
      },
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.download,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void onClickBackButton() {}

  @override
  Color? pageBackgroundColor() {
    return null;
  }
}
