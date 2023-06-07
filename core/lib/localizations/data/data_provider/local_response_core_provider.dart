import 'dart:convert';
import 'package:core/localizations/data/model/language.dart';
import 'package:core/localizations/data/model/localization.dart';
import 'package:core/utils/logger_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalResponseCoreDataProvider {
  final logger = LoggerProvider.logger;

  Future<Localization> getLanguageStringsFromAsset(Language ln) async {
    try {
      String? fileName;
      if (ln == Language.en) {
        fileName =
            "packages/core/assets/localization/localization_en.json";
      }
      if (ln == Language.es) {
        fileName =
            "packages/core/assets/localization/localization_es.json";
      }

      String data = await rootBundle.loadString(fileName!);
      //todo: need to update
      Localization response = Localization.fromJson(jsonDecode(data));
      return response;
    } catch (error, stacktrace) {
      logger.d("Exception occurred: $error stackTrace: $stacktrace");
      return Localization();
    }
  }
}
