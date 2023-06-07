import 'dart:async';

class PhoneValidator{
  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink) {
      if(phone.length >7 || phone.contains(" ") || phone.trim().isEmpty){
        sink.addError("Phone number should be 7 numerical characters");
      }
      else {
        sink.add(phone);
      }
    },
  );
}