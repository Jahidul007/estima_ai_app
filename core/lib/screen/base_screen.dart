import 'dart:async';
import 'package:core/controller/base_controller.dart';
import 'package:core/model/base_response.dart';
import 'package:core/screen/token_expiry_handler.dart';
import 'package:core/utils/show_toast.dart';
import 'package:core/widget/element/snackbar_widget.dart';
import 'package:core/widget/no_network_dialog.dart';
import 'package:core/widget/show_success_dialog.dart';
import 'package:flutter/material.dart';

import '../di/setup_core.dart';
import 'base_page_screen.dart';
import 'subscription_handler.dart';

abstract class BaseScreen<Page extends BasePageScreen>
    extends BasePageScreenState<Page> with SubscriptionHandler {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    bindControllers();
    setupListenersForBloc(blocs);
  }

  @override
  void handleStates(PageState event, String errorMessage) {
    if (event == PageState.FAILED || event == PageState.MESSAGE) {
      if (errorMessage.trim().isNotEmpty) {
        //todo extract this
        showToast(errorMessage);
      }
    } else if (event == PageState.NO_INTERNET) {
      //todo extract this
      showNoNetworkDialog(context, retryFunctionOnNoNetwork());
    } else if (event == PageState.UNAUTHORIZED) {
      //todo handle this section
      getIt<TokenExpiryHandler>().onTokenExpired(context);
    }
  }

  @override
  StreamSubscription addRefreshListener(BaseController controller) {
    return controller.isRefreshed.listen((event) {
      if (event == true) {
        //todo extract this
        onPageRefresh();
        controller.updateRefresh(false);
      }
    });
  }

  @override
  StreamSubscription addListenerForSnackBar(BaseController controller) {
    return controller.message.listen((event) {
      //todo extract this
      showSnackBar(globalKey, event.toString());
    });
  }

  Future<void> showResponseDialog(BaseResponse event,
      {Function? onSuccess, Function? onFailure}) async {
    Color iconColor = event.isSuccess ? Colors.green : Colors.red;
    String title = event.isSuccess ? "${localization.commonSuccess}" : "${localization.commonFailure}";
    String iconName = event.isSuccess
        ? "images/ic_success.png"
        : "images/ic_alert_triangle.png";

    onFailure ??= () {
      Navigator.of(context).pop();
    };

    onSuccess ??= () {
      Navigator.of(context).pop();
    };

    Function onTapOkay = event.isSuccess ? onSuccess : onFailure;

    showSuccessDialog(context, title, event.msg,
        onTapOkay: onTapOkay, iconName: iconName, iconColor: iconColor);
  }

  @override
  void dispose() {
    disposeSubscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: pageBackgroundColor() ?? Colors.white,
          key: globalKey,
          appBar: appBar(),
          resizeToAvoidBottomInset: getResizeToAvoidBottomInset(),
          floatingActionButtonLocation: floatingActionButtonPosition(),
          floatingActionButton: floatingActionButton(),
          body: SafeArea(
            child: body(),
          ),
          bottomNavigationBar: bottomNavigationBar(),
        ),
        loadingWidgets(),
      ],
    );
  }

  Stack loadingWidgets() {
    return Stack(
      children: _getLoadingWidgets(),
    );
  }

  List<Widget> _getLoadingWidgets() {
    List<Widget> widgets = [];

    if (blocs.isEmpty) {
      widgets.add(Container());
    } else {
      for (var baseBloc in blocs) {
        widgets.add(loadingWidget(baseBloc.stateController));
      }
    }

    return widgets;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  bool? getResizeToAvoidBottomInset(){
    return true;
  }

  Widget body();

  PreferredSizeWidget? appBar();

  Widget? floatingActionButton();

  FloatingActionButtonLocation? floatingActionButtonPosition() {
    return null;
  }

  Widget drawer() {
    return const SizedBox();
  }

  Color? pageBackgroundColor();

  void onPageRefresh() {}
}
