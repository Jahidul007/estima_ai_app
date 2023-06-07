import 'dart:convert';

import 'custom_enecoder_decoder.dart';

class JsonEncoderDecoder extends CustomEncoderDecoder{
  @override
  String encode(Map<String,dynamic> body){
    late String bodyString;
    try {
      bodyString = jsonEncode(body);
    }catch(e){
      rethrow;
    }
    return bodyString;
  }

  @override
  Map<String,dynamic> decode(String body) {
    late Map<String,dynamic> bodyMap;
    try {
      bodyMap = jsonDecode(body);
    }catch(e){
      rethrow;
    }
    return bodyMap;
  }
}