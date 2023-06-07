import 'package:core/screen/base_page_screen.dart';
import 'package:core/screen/base_screen.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class UpComingScreen extends BasePageScreen {
  const UpComingScreen({Key? key}) : super(key: key);

  @override
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends BaseScreen {
  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: primaryColor,
      elevation: 0.0,
      centerTitle: true,
      title:  Text(
        "${localization.commonUpcoming}",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  bindControllers() {}

  @override
  Widget body() {
    return  Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Text(
          "${localization.commonUpcomingSubtitle}",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget floatingActionButton() {
    return Container();
  }

  @override
  void onClickBackButton() {
    Navigator.of(context).pop();
  }

  @override
  Color pageBackgroundColor() {
    return Colors.white;
  }
}
