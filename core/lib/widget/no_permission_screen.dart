import 'package:core/screen/base_page_screen.dart';
import 'package:core/screen/base_screen.dart';
import 'package:flutter/material.dart';

class NoPermissionScreen extends BasePageScreen {
  const NoPermissionScreen({Key? key}) : super(key: key);

  @override
  _NoPermissionScreenState createState() => _NoPermissionScreenState();
}

class _NoPermissionScreenState extends BaseScreen {
  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "${localization.commonNoAccess}",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  bindControllers() {}

  @override
  Widget body() {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/no_access.png",
                height: 200,
                width: 200,
              ),
              Text(
                "${localization.commonNoAccessSubtitle}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
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
