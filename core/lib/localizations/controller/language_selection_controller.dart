import 'package:core/controller/base_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/model/language.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:rxdart/subjects.dart';

class LanguageSelectionController extends BaseController {
  final PreferenceManager _preferenceManager  = getIt.get<PreferenceManager>();

  LanguageSelectionController() {
    getCurrentLanguage();
  }

  final BehaviorSubject<Language> _languageController = BehaviorSubject();

  Stream<Language> get languageStream => _languageController.stream;

  Future<void> getCurrentLanguage() async {
    var response = await _preferenceManager.getLocalization();
    // logger.d("local language "+response);
    _languageController.add(getLanguageFromString(response));
  }
}
