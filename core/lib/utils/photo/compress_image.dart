import 'dart:async' show Future;
import 'dart:io' show File;
import 'package:core/utils/logger_provider.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart' show BuildContext;
import 'package:image/image.dart' as im;
import 'package:logger/logger.dart';
import 'dart:math' as math;
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

final Logger logger = LoggerProvider.logger;

Future<File?> getCompressedPicture(BuildContext context, File? _imageFile) async {
  if (_imageFile == null) {
    return null;
  }

  final tempDir = await getTemporaryDirectory();
  final rand = math.Random().nextInt(10000);
  _CompressObject compressObject =
  _CompressObject(_imageFile, tempDir.path, rand);
  String? filePath = await _compressImage(compressObject);
  logger.d("new path: $filePath");

  File? file;

  if(filePath!=null) {
    file = File(filePath);
  }

  return file;
}

Future<String?> _compressImage(_CompressObject object) async {
  return compute(_decodeImage, object);
}

String? _decodeImage(_CompressObject object) {
  im.Image? image = im.decodeImage(object.imageFile.readAsBytesSync());

  if(image!=null) {
    im.Image? smallerImage = im.copyResize(
      image,
      height: 512,
    ); // choose the size here, it will maintain aspect ratio
    var decodedImageFile = File(object.path + '/img_${object.rand}.jpg');
    decodedImageFile.writeAsBytesSync(im.encodeJpg(smallerImage, quality: 85));

    return decodedImageFile.path;
  }
  else{
    return null;
  }
}

class _CompressObject {
  File imageFile;
  String path;
  int rand;

  _CompressObject(this.imageFile, this.path, this.rand);
}