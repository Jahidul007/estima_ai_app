import 'dart:async';

import 'package:core/utils/regex_const.dart';

class MobileEmailValidator {
  final validateMobileEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (_isNumeric(email)) {
        if (email.length > 10 && email.length < 12) {
          sink.add(email);
        } else {
          sink.addError("Enter a valid email or phone number");
        }
      }else{
        if (emailRegex.hasMatch(email)) {
          sink.add(email);
        } else {
          sink.addError("Enter a valid email or phone number");
        }
      }

    },
  );
}

bool _isNumeric(String str) {
  if (str.trim().isEmpty) {
    return false;
  }
  return double.tryParse(str) != null;
}
