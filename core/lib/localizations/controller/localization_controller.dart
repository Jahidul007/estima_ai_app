import 'package:core/controller/base_controller.dart';
import 'package:core/di/setup_core.dart';
import 'package:core/localizations/data/data_provider/local_response_core_provider.dart';
import 'package:core/localizations/data/model/language.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/localizations/data/repository/localization_repository.dart';
import 'package:core/network/preference_manager/preference_manager.dart';
import 'package:rxdart/rxdart.dart';

class LocalizationController extends BaseController {
  final PreferenceManager preferenceManager = getIt.get<PreferenceManager>();

  LocalizationController();

  final LocalizationsRepository _localizationsRepository =
  LocalizationsRepository(LocalResponseCoreDataProvider());
  final BehaviorSubject<Localization> _localizationController =
  BehaviorSubject<Localization>();

  Stream<Localization> get localizationStream => _localizationController.stream;

  Localization get localization => _localizationController.value;

  Future<void> changeLocalization(Language ln) async {
    logger.d("changing localization ${ln.name}");
    showLoadingState();
    final Localization response =
    await _localizationsRepository.getLanguageStringsFromAsset(ln);
    await preferenceManager.saveLocalization(ln.name);
    logger.d("save localization ${ln.name}");
    _localizationController.add(response);

    if(getIt.isRegistered<Localization>()) {
      getIt.unregister<Localization>();
    }
    getIt.registerSingleton<Localization>(response);

    showSuccessState();
  }
}
