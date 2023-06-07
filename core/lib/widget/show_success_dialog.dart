import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/utils/constants.dart';
import 'package:core/widget/app_button.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:flutter/material.dart';

import 'app_button_small.dart';

showSuccessDialog(BuildContext context, String msg, String subtitle,
    {Function? onTapOkay,
    Function? onTapCancel,
    String iconName = "images/ic_success.png",
    Color iconColor = Colors.green}) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      barrierColor: const Color(0xff002540).withOpacity(0.4),
      isScrollControlled: true,
      builder: (BuildContext buildContext) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    iconName,
                    color: iconColor,
                  ),
                ),
                Container(height: 20),
                msg.trim().isNotEmpty
                    ? Align(
                        child: Text(
                          msg,
                          style: textNormalStyle.copyWith(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
                Container(height: msg.trim().isNotEmpty ? 20 : 0),
                Align(
                  child: Text(
                    subtitle,
                    style: textNormalStyle.copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(height: 20),
                Row(
                  children: [
                    if (onTapCancel != null)
                      Expanded(
                        child: AppButtonSmall(
                          onPressed: () {
                            onTapCancel();
                          },
                          title: "${getIt.get<Localization>().commonCancel}",
                        ),
                      ),
                    if (onTapCancel != null) customWidth(),
                    Expanded(
                      child: AppButton(
                        title: "${getIt.get<Localization>().commonOk}",
                        onPressed: () {
                          if (onTapOkay != null) {
                            onTapOkay();
                          } else {
                            Navigator.of(buildContext).pop();
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
