import 'dart:async';

class LoginValidator{
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if(email.length >= 0){
        sink.add(email);
      } else {
        sink.addError("Enter a valid email");
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if(password.length >=4){
        sink.add(password);
      } else {
        sink.addError("Password length must be 4");
      }
    },
  );

}