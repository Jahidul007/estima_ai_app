
import 'dart:async';

class PinValidator{
  final validatePin = StreamTransformer<String, String>.fromHandlers(
    handleData: (String pin, sink) {
      try{
        int pinInt = int.parse(pin);
        if(pin.length== 4){
          sink.add(pin);
        } else {
          sink.addError("Password length must be 4");
        }
      }catch(e){
        sink.addError("Input only number");
      }
    },
  );
}