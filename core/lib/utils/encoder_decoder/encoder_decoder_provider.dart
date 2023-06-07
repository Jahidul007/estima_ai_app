import 'package:core/utils/encoder_decoder/custom_enecoder_decoder.dart';
import 'package:core/utils/encoder_decoder/json_encoder_decoder_impl.dart';

class EncoderDecoderProvider{

  EncoderDecoderProvider._();

  static CustomEncoderDecoder? _encoderDecoder;

  static CustomEncoderDecoder get encoderDecoder=>
      _encoderDecoder ??= JsonEncoderDecoder();
}