import 'package:core/screen/base_page_screen.dart';
import 'package:core/screen/base_screen.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/extension/string_extension.dart';
import 'package:core/utils/string_utils.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:estima_ai_app/app/module/dashboard/controller/user_profile_with_history_controller.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_profile_history_response.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/widget/show_user_story_generator_widget.dart';
import 'package:estima_ai_app/app/route/estima_app_route.dart';
import 'package:flutter/material.dart';

import 'widget/show_user_story_and_save_widget.dart';

class DashboardScreen extends BasePageScreen {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseScreen<DashboardScreen> {
  UserProfileWithHistoryController userProfileController =
      UserProfileWithHistoryController();

  @override
  void initState() {
    super.initState();
    userProfileController.getUserProfileWithHistory();

    userProfileController.reportDataStream.listen(
      (event) {
        if (event != null) {
          showUserStoriesAndSave(context, event, userProfileController);
        }
      },
    );
  }

  @override
  void onPageRefresh() {
    super.onPageRefresh();
    userProfileController.refreshPage();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: StreamBuilder(
        stream: userProfileController.userStoriesStream,
        builder: (context, snapshot) {
          UserProfileWithHistory? userProfileWithHistory;
          if (snapshot.hasData) {
            userProfileWithHistory = snapshot.data!;
          }
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            title: Text(
              userProfileWithHistory?.name ?? "",
              style: body2regular.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            subtitle: Text(
              userProfileWithHistory?.email ?? "",
              style: body2regular.copyWith(fontSize: 18, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  @override
  bindControllers() {
    addControllers(userProfileController);
  }

  @override
  Widget body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 50, top: 10, left: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: userProfileController.userStoriesStream,
          builder: (context, snapshot) {
            List<ReportHistories> reportHistories = [];
            if (snapshot.hasData && snapshot.data!.reportHistories != null) {
              reportHistories = snapshot.data!.reportHistories!;
            }
            if (reportHistories.isNotEmpty) {
              return Column(
                children: [
                  Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      color: primaryColor,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              defaultIfNull("Feature Title"),
                              style: body2regular.copyWith(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              defaultIfNull("Date Time"),
                              style: body2regular.copyWith(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              defaultIfNull("Durations(Hour)"),
                              style: body2regular.copyWith(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          //customWidth(width: 30),
                          Expanded(
                            flex: 1,
                            child: Text(
                              " \t\t\t   Action",
                              style: body2regular.copyWith(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10, bottom: 10, right: 0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  defaultIfNull(
                                      "${reportHistories[index].title}"),
                                ),
                              ),
                              customWidth(),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  defaultIfNull(
                                          "${reportHistories[index].generationTime}")
                                      .getFormattedDateFromFormattedString(
                                          currentFormat: "yyyy-mm-ddTHH:mm:ssZ",
                                          desiredFormat: "dd-MMM-yyyy hh:mm a"),
                                ),
                              ),
                              customWidth(),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  defaultIfNull(
                                      "${reportHistories[index].jsonData!.totalTime}"),
                                ),
                              ),
                              customHeight(),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      EstimaAppRoute.userHistoryDetailsScreen,
                                      arguments: reportHistories[index],
                                    );
                                  },
                                  child:  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: primaryColor.withOpacity(0.2),
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: reportHistories.length,
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget? floatingActionButton() {
    return InkWell(
      onTap: () {
        showUserStoryGeneratorWidget(context, userProfileController);
      },
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Text(
            "Generate",
            style: body2regular.copyWith(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
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
