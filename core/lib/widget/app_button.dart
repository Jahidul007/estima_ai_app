import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/utils/constants.dart';
import 'package:core/widget/custom_height_width.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final double height;
  final double borderRadius;
  final Color color;
  final bool? showIcon;

  AppButton(
      {Key? key,
      required this.onPressed,
      this.title,
      this.height = 42,
      this.borderRadius = 4,
      this.color = primaryColor,
      this.showIcon = false})
      : super(key: key);

  final Localization localization = getIt.get<Localization>();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: lightGreyColor,
      minWidth: MediaQuery.of(context).size.width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: color,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon==true)
            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child:  Icon(
                Icons.add,
                color: primaryColor,
                size: 32,
              ),
            ),
          if (showIcon==true)
            customWidth(),
          Text(
            title ?? "${localization.commonNext}",
            style: normalWhiteStyle.copyWith(fontSize: 22),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
