import 'package:connectivity/connectivity.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_button.dart';
import 'info_text_widget.dart';

Future<void> showNoNetworkDialog(
  BuildContext buildContext,
  Function retry, {
  String? title,
  String? subTitle,
}) {
  final Localization localization = getIt.get<Localization>();

  return showDialog<void>(
    context: buildContext,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('images/ic_no_internet.svg'),
                    const SizedBox(
                      height: 30,
                    ),
                     InfoTextWidget(
                      title:title??"${localization.commonNoNetworkTitle}",
                      subtitle:subTitle??"${localization.commonNoNetworkTitle}",
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  onPressed: () {
                    checkConnection().then((connectionAvailable) {
                      if (connectionAvailable) {
                        Navigator.of(context).pop();
                        retry();
                      }
                    });
                  },
                  title: localization.commonRetry!,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}
