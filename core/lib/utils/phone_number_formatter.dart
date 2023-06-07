import 'package:core/network/error_handlers.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

String getPhoneNumber(String phoneNum) {
  var str = splitPhoneNumber(phoneNum);
  var controller = MaskedTextController(text: '', mask: '000-0000');
  controller.updateText(str);
  return controller.text.isNotEmpty
      ? "+1-868-" + controller.text
      : "Not Available";
}

validatePhoneNumber(String text) {
  if (!(text.replaceAll("-", "").length >= 7) && text.isNotEmpty) {
    return "Phone number should be 7 numerical characters";
  }
  return null;
}

splitPhoneNumber(String? phoneNumber) {
  if(phoneNumber!.isEmpty){
    logger.d(phoneNumber);
    return "";
  }
  var str = phoneNumber.split("-");
  return str.join();
}
