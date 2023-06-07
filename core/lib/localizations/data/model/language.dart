enum Language {
  en,
  es,
}

getLanguageToString(Language language) {
  switch (language) {
    case Language.en:
      return "EN";
    case Language.es:
      return "ES";
  }
}

Language getLanguageFromString(String str) {
  Language l = Language.values.firstWhere((e) => e.name == str);
  return l;
}