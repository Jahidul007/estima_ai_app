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
import 'package:flutter_svg/flutter_svg.dart';

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
      title: StreamBuilder(
        stream: userProfileController.userStoriesStream,
        builder: (context, snapshot) {
          UserProfileWithHistory? userProfileWithHistory;
          if (snapshot.hasData) {
            userProfileWithHistory = snapshot.data!;
          }
          return ListTile(
            leading: SvgPicture.asset(
              'images/ic_logo.svg',
              height: 50,
            ),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userProfileWithHistory?.name ?? "",
                          style: body2regular.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          userProfileWithHistory?.email ?? "",
                          style: body2regular.copyWith(
                              fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    customWidth(width: 10),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person),
                    ),
                  ],
                )
              ],
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

  List<String> listData = [
    "Leverages artificial intelligence to estimate software development projects",
    "Analyzes parameters, historical data, and project details for precise estimates",
    "Learns from past projects to identify patterns, dependencies, and risks",
    "Handles uncertainties and simulates scenarios for contingency planning",
    "User-friendly interface for easy input of project details",
    "Reduces time and effort required for estimation",
    "Enhances resource planning and project management",
    "Provides data-driven estimates for project timelines, resource allocation, and budgeting",
  ];

  @override
  Widget body() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, top: 20, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          children: [
                            Text(
                              "Introducing our cutting-edge AI-based "
                              "software estimation software, designed to revolutionize the way software "
                              "projects are estimated. Our advanced solution harnesses the power of artificial "
                              "intelligence to provide accurate and reliable estimates for software development. "
                              "With traditional estimation methods often plagued by subjectivity and human error, "
                              "our AI software estimation software brings a new level of precision and efficiency "
                              "to the process. By leveraging sophisticated machine learning algorithms and "
                              "vast amounts of historical project data, it analyzes various parameters and "
                              "factors to generate highly accurate estimates.\n\nKey Features:\n",
                              style: body2regular.copyWith(fontSize: 18),
                              textAlign: TextAlign.justify,

                            ),
                            ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 0),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Text(
                                  "• ${listData[index]}",
                                  style: body2regular.copyWith(
                                    fontSize: 18,
                                  ),
                                );
                              },
                              itemCount: listData.length,
                            )
                          ],
                        ),
                      ),
                    ),
                    customHeight(height: 16),
                    FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Card(
                        color: primaryColor,
                        elevation: 10,
                        child: InkWell(
                          onTap: () {
                            showUserStoryGeneratorWidget(
                                context, userProfileController);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 24),
                            child: Center(
                              child: Text(
                                "Estimate a Project",
                                style: body2regular.copyWith(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          customWidth(width: 24),
          Expanded(
            child: StreamBuilder(
              stream: userProfileController.userStoriesStream,
              builder: (context, snapshot) {
                List<ReportHistories> reportHistories = [];
                if (snapshot.hasData &&
                    snapshot.data!.reportHistories != null) {
                  reportHistories = snapshot.data!.reportHistories!;
                }
                if (reportHistories.isNotEmpty) {
                  return Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            color: primaryColor,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    defaultIfNull("Project Title"),
                                    style: body2regular.copyWith(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    defaultIfNull("Date Time"),
                                    style: body2regular.copyWith(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    defaultIfNull("Durations \n\t (Hour)"),
                                    style: body2regular.copyWith(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                //customWidth(width: 30),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Action",
                                    style: body2regular.copyWith(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 0),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          defaultIfNull(
                                              "${reportHistories[index].title}"),
                                        ),
                                      ),
                                      customWidth(),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          defaultIfNull(
                                                  "${reportHistories[index].generationTime}")
                                              .getFormattedDateFromFormattedString(
                                                  currentFormat:
                                                      "yyyy-MM-ddTHH:mm:ssZ",
                                                  desiredFormat:
                                                      "dd-MMM-yyyy\n hh:mm a"),
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
                                              EstimaAppRoute
                                                  .userHistoryDetailsScreen,
                                              arguments: reportHistories[index],
                                            ).then(
                                              (value) => userProfileController
                                                  .getUserProfileWithHistory(),
                                            );
                                          },
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                primaryColor.withOpacity(0.2),
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
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: reportHistories.length,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
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
