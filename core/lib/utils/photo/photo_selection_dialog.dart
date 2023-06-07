import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/widget/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

showPhotoChooseDialog(
    {required BuildContext context,
    required Function() onPickPhoto,
    required Function() onTakePhoto}) {
  Localization _localization = getIt.get<Localization>();
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext buildContext) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_localization.photoSelectTitle}",
                        style: textArchivoPrimary600.copyWith(fontSize: 18),
                      ),
                      InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('images/ic_cross_round.svg'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                customDividerGrey(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      getIconAndText(
                          "ic_gallery.svg",
                          "${_localization.photoSelectFromGallery}",
                          onPickPhoto),
                      const SizedBox(height: 10),
                      getIconAndText("ic_camera.svg",
                          "${_localization.photoTakeFromCamera}", onTakePhoto),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget getIconAndText(String svgName, String text, Function() onClick) {
  return InkWell(
    onTap: onClick,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: primaryColor.withOpacity(0.1),
          radius: 22,
          child: SvgPicture.asset(
            'images/$svgName',
            color: primaryColor,
            height: 24,
            width: 24,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: textArchivo.copyWith(fontSize: 18),
        ),
      ],
    ),
  );
}
