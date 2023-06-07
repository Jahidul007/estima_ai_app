import 'package:core/controller/base_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/localizations/controller/localization_controller.dart';
import 'package:core/localizations/data/model/language.dart';
import 'package:core/network/preference_manager/preference_manager.dart';

class SplashController extends BaseController {
  final PreferenceManager preferenceManager = getIt.get<PreferenceManager>();

  Future<void> getLocalization() async {
    String localizationStr = await preferenceManager.getLocalization();
    await getIt.get<LocalizationController>()
        .changeLocalization(getLanguageFromString(localizationStr));
  }
}
