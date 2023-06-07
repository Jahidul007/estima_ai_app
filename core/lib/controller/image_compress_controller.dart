import 'dart:io';

import 'package:core/utils/logger_provider.dart';
import 'package:core/utils/photo/compress_image.dart';
import 'package:core/utils/photo/photo_util.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final Logger logger = LoggerProvider.logger;

Future<File?> processPhoto(BuildContext context, File _image) async {
  double originalImageSize = await getFileSizeInKb(_image);

  File? _compressedImage;

  _compressedImage = await getCompressedPicture(context, _image);
  if (_compressedImage != null) {
    double compressedSize = await getFileSizeInKb(_compressedImage);
    logger.d("File: original size ${await getFileSizeInKb(_image)}");
    logger.d("File: compressed size $compressedSize");
    if (compressedSize > 512) {
      processPhoto(context, _compressedImage);
    } else {
      return _compressedImage;
    }
  } else {
    return _image;
  }
}
