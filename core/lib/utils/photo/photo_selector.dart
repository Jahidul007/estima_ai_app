import 'dart:io';
import 'package:core/screen/base_screen.dart';
import 'package:core/utils/logger_provider.dart';
import 'package:core/utils/photo/photo_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final Logger logger = LoggerProvider.logger;

mixin PhotoSelector on BaseScreen {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource src) async {
    final pickedFile = await picker.pickImage(
      source: src,
      preferredCameraDevice: CameraDevice.front,
    );
    ("File: picked file!");
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _processPhoto(_image!);
      setState(() {
        logger.d("New photo selected");
      });
    }
  }

  void _processPhoto(File image) async {
    /* final _compressedImage = await getCompressedPicture(context, _image);
    if (_compressedImage != null) {
      double compressedSize = await getFileSizeInKb(_compressedImage);
      logger.d("File: original size ${await getFileSizeInKb(_image)}");
      logger.d("File: compressed size $compressedSize");
      if (compressedSize > 1024) {
        _processPhoto(_compressedImage);
        return;
      }
      onPhotoSelectionDone(_compressedImage);
    } else {
      logger.d("Could not compress image");
    }*/
    onPhotoSelectionDone(image);
  }

  onPhotoSelectionDone(File photo);

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.image) {
          _image = File(response.file!.path);
          logger.d("Lost: New photo selected");
          _processPhoto(_image!);
        }
      });
    } else {
      logger.d(response.exception);
    }
  }

  showPhotoSelectionDialog() {
    showPhotoChooseDialog(
      context: context,
      onPickPhoto: _onPickPhoto,
      onTakePhoto: _onTakePhoto,
    );
  }

  _onPickPhoto() {
    getImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  _onTakePhoto() {
    getImage(ImageSource.camera);
    Navigator.pop(context);
  }
}
