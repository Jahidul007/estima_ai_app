import 'package:core/screen/base_page_screen.dart';
import 'package:core/screen/base_screen.dart';
import 'package:core/utils/constants.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:estima_ai_app/app/module/dashboard/data/model/user_profile_history_response.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/report_generation/pdf_generator_widget.dart';
import 'package:estima_ai_app/app/module/dashboard/screen/widget/feature_breakdown_widget.dart';
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
  bindControllers() {}

  @override
  Widget body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Text(
            "Total Estimated Time: ${widget.reportHistories.jsonData?.totalTime}",
            style: body2regular.copyWith(
                fontWeight: FontWeight.bold, fontSize: 24),
          ),
          customHeight(),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.reportHistories.jsonData!.reportDataList!.length,
            itemBuilder: (context, ind) {
              return FeatureBreakDownWidget(
                reportDataList:
                    widget.reportHistories.jsonData!.reportDataList![ind],
              );
            },
            separatorBuilder: (context, index) => customHeight(),
          )
        ],
      ),
    );
  }

  @override
  Widget? floatingActionButton() {
    return InkWell(
      onTap: () async {
        await PDFDownloadGenerator(widget.reportHistories).generateInvoice();
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
