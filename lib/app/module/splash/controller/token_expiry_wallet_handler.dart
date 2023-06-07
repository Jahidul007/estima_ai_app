import 'package:core/screen/token_expiry_handler.dart';
import 'package:core/utils/show_toast.dart';
import 'package:estima_ai_app/app/route/estima_app_route.dart';
import 'package:flutter/material.dart';

class TokenExpiryHandlerWallet extends TokenExpiryHandler {
  @override
  void onTokenExpired(BuildContext context) async {
    if (ModalRoute.of(context)?.settings.name != EstimaAppRoute.authScreen) {


      showToast('Your session has been expired');

      Navigator.of(context).pushNamedAndRemoveUntil(
          EstimaAppRoute.authScreen, (route) => false,
          arguments: null);
    }
  }
}
