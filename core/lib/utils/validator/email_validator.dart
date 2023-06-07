import 'dart:async';

import 'package:core/utils/regex_const.dart';



class EmailValidator{
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if(emailRegex.hasMatch(email)){
        sink.add(email);
      } else {
        sink.addError("Enter a valid email");
      }
    },
  );

  final validateUserName = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if(value.length>8){
        sink.add(value);
      } else {
        sink.addError("Enter a valid user name");
      }
    },
  );
}