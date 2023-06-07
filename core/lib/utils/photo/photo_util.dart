import 'dart:io';

import 'package:core/utils/photo/compress_image.dart';

Future<int> getFileSizeInBytes(File image) async{
  final bytes = (await image.readAsBytes()).lengthInBytes;
  return bytes;
}

Future<double> getFileSizeInKb(File? image) async{
 if(image!=null) {
    final bytes = await getFileSizeInBytes(image);
    return bytes / 1024;
  }else{
   logger.d("Provided file is null");
   return 0.0;
 }
}

Future<double> getFileSizeInMb(File image) async{
  final kb = await getFileSizeInKb(image);
  return kb/1024;
}