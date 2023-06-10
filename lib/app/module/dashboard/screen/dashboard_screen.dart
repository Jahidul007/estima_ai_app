import 'package:core/screen/base_page_screen.dart';
import 'package:core/screen/base_screen.dart';
import 'package:core/utils/constants.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 100,
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 16),
              color: primaryColor,
              constraints: BoxConstraints(maxWidth: 100),
              child: Text("Report"),
            ),
          ),
          Expanded(
            flex: 7,
            child: StreamBuilder(
              stream: userProfileController.userStoriesStream,
              builder: (context, snapshot) {
                List<ReportHistories> reportHistories = [];
                if (snapshot.hasData &&
                    snapshot.data!.reportHistories != null) {
                  reportHistories = snapshot.data!.reportHistories!;
                }
                return reportHistories.isNotEmpty
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${reportHistories[index].title}"),
                              customHeight(),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    EstimaAppRoute.userHistoryDetailsScreen,
                                    arguments: reportHistories[index],
                                  );
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.more_horiz,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: reportHistories.length,
                      )
                    : Container();
              },
            ),
          )
        ],
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
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Generate",
            style: body2regular.copyWith(color: Colors.white),
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
