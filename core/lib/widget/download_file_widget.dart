import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/utils/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DownloadFileWidget extends StatelessWidget {
  final String fileName;

  DownloadFileWidget(this.fileName, {Key? key}) : super(key: key);

  final Localization localization = getIt.get<Localization>();

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'images/ic_download.svg',
              height: 32,
              width: 32,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   "${localization.commonDownloadFile}",
                    style: captionGrey.copyWith(fontSize: 16),
                  ),
                  Text(
                    fileName,
                    style: captionGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
