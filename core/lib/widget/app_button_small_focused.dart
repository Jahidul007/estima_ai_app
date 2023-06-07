import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class AppButtonSmallFocused extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final double radiusValue;
  final bool isIconShow;
  final bool isRadius;

  AppButtonSmallFocused({
    Key? key,
    required this.onPressed,
    required this.title,
    this.radiusValue = 5,
    this.isIconShow = false,
    this.isRadius = true,
  }) : super(key: key);

  final Localization localization = getIt.get<Localization>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: 12,
          ),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRadius ? radiusValue : 0),
          ),
        ),
        onPressed: onPressed,
        child: isIconShow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.button?.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  const Icon(Icons.arrow_forward)
                ],
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.button?.copyWith(
                      fontSize: 16,
                    ),
              ),
      ),
    );
  }
}
