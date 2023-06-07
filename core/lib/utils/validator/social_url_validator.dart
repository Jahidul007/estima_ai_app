import 'dart:async';

class SocialUrlValidator{
  final validateFacebookUrl = StreamTransformer<String, String>.fromHandlers(
    handleData: (url, sink) {
      var regX = RegExp(r"(?:https?:\/\/)?(?:www\.)?(?:facebook|fb|m\.facebook)\.(?:com|me)\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]+)(?:\/)?");
      if(url.trim().isEmpty || regX.hasMatch(url)){
        sink.add(url);
      } else {
        sink.addError("Enter a valid facebook url");
      }
    },
  );

  final validateInstagramUrl = StreamTransformer<String, String>.fromHandlers(
    handleData: (url, sink) {
      var regX = RegExp(r"(https?)?:?(www)?instagram\.com/[a-z].{3}");
      if(url.trim().isEmpty ||regX.hasMatch(url)){
        sink.add(url);
      } else {
        sink.addError("Enter a valid instagram url");
      }
    },
  );

  final validateLinkedinUrl = StreamTransformer<String, String>.fromHandlers(
    handleData: (url, sink) {
      var regX = RegExp(r"^https?:\/\/[a-z]{2,3}\.linkedin\.com\/.*$");
      if(url.trim().isEmpty ||regX.hasMatch(url)){
        sink.add(url);
      } else {
        sink.addError("Enter a valid linked in url");
      }
    },
  );
}