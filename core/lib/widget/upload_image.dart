import 'dart:io';
import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/photo/file_selector.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class UploadImageWidget extends StatelessWidget with FileSelector {
  final Function(File file) onImageSelected;
  final String? title;
  final bool? roundShape;

  UploadImageWidget(
      {Key? key,
      required this.onImageSelected,
      this.title,
      this.roundShape = false})
      : super(key: key);

  final Localization _localization = getIt.get<Localization>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showFileSelectionDialog(
            context, "${_localization.commonUploadImageMsg}");
      },
      child: roundShape == true
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(50)),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.camera_alt,
                  size: 32,
                ),
              ),
            )
          : DottedBorder(
              color: Colors.grey,
              strokeWidth: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/ic_uploads.svg',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? "${_localization.commonUploadImage}",
                          style: captionGrey.copyWith(fontSize: 16),
                        ),
                        Text("${_localization.commonFileMaxSize}",
                            style: captionGrey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  onPhotoSelectionDone(File photo, String title) {
    onImageSelected(photo);
  }
}
