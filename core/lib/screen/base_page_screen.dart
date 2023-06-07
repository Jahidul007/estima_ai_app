import 'package:core/controller/base_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:core/widget/loading_dialog.dart';

abstract class BasePageScreen extends StatefulWidget {
  const BasePageScreen({Key? key}) : super(key: key);
}

abstract class BasePageScreenState<Page extends BasePageScreen>
    extends State<Page> with LoadingUtil {

  @override
  void initState() {
    initialize();
    super.initState();
  }

  final Logger logger = Logger();
  Localization localization = getIt.get<Localization>();

  bool _isBack = true;

  List<BaseController> blocs = [];

  void onClickBackButton();

  void isBackButton(bool isBack) {
    _isBack = isBack;
  }

  addControllers(BaseController _controller) {
    blocs.add(_controller);
  }

  Function retryFunctionOnNoNetwork() {
    return () {};
  }

  bindControllers();

  void initialize(){}
}