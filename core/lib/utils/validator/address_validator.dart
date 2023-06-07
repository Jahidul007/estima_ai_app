import 'dart:async';

class AddressValidator{
  final validateAddress = StreamTransformer<String, String>.fromHandlers(
    handleData: (address, sink) {
      if(address.trim().isNotEmpty){
        sink.add(address);
      } else {
        sink.addError("Enter a valid address");
      }
    },
  );
}