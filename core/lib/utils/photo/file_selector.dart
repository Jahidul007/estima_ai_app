import 'dart:io';

import 'package:core/controller/base_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../logger_provider.dart';
import 'photo_selection_dialog.dart';

final Logger logger = LoggerProvider.logger;

mixin FileSelector {
  File? _file;
  final picker = ImagePicker();

  Future getImage(
      {ImageSource? src,
      required BuildContext context,
      required String title}) async {
    if (src != null) {
      getImageFromCamera(src, context, title);
    } else {
      getFileFromDirectory(src, context, title);
    }
  }

  final BehaviorSubject<PageState> fileUploadLoadingController =
      BehaviorSubject<PageState>();

  _processPhoto(File image, BuildContext context, String title) async {
    onPhotoSelectionDone(image, title);
  }

  onPhotoSelectionDone(File photo, String title);

  showFileSelectionDialog(BuildContext context, String title) {
    showPhotoChooseDialog(
      context: context,
      onPickPhoto: () {
        getImage(src: ImageSource.gallery, context: context, title: title);
        Navigator.pop(context);
      },
      onTakePhoto: () {
        getImage(src: ImageSource.camera, context: context, title: title);
        Navigator.pop(context);
      },
    );
  }

  void getImageFromCamera(
      ImageSource src, BuildContext context, String title) async {
    final pickedFile = await picker.pickImage(source: src);
    logger.d("File: picked file!");
    if (pickedFile != null) {
      _file = File(pickedFile.path);
      _processPhoto(_file!, context, title);
    }
  }

  void getFileFromDirectory(
      ImageSource? src, BuildContext context, String title) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docx',
        'xlx',
        'xlxs',
        'ppt',
        'pptx'
      ],
    );
    if (result != null) {
      _file = File(result.files.single.path!);
      _processPhoto(_file!, context, title);
    }
  }
}
