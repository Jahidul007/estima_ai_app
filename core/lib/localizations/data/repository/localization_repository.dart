import 'package:core/localizations/data/data_provider/local_response_core_provider.dart';
import 'package:core/localizations/data/model/language.dart';
import 'package:core/localizations/data/model/localization.dart';

class LocalizationsRepository {
  final LocalResponseCoreDataProvider _localResponseProvider;

  LocalizationsRepository(this._localResponseProvider);

  Future<Localization> getLanguageStringsFromAsset(Language ln) async {
    return _localResponseProvider.getLanguageStringsFromAsset(ln);
  }
}

