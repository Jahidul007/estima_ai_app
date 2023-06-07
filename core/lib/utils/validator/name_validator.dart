import 'dart:async';

class NameValidator{
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      var regX = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
      if(name.trim().isEmpty /*|| !regX.hasMatch(name)*/){
        sink.addError("Enter a valid name");
      } else {
        sink.add(name);
      }
    },
  );
}