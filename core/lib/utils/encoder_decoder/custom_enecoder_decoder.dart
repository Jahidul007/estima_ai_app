abstract class CustomEncoderDecoder {
  String encode(Map<String,dynamic> body);
  Map<String,dynamic> decode(String body);
}