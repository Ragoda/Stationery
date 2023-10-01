var languages = [
  LanguageModel("English", 'en', 'Us'),
  LanguageModel("عربي", 'ar', 'Sa'),
  // LanguageModel("Bengali", "bn"),
  // LanguageModel("Telugu", "te"),
  // LanguageModel("Urdu", "ur"),
  // LanguageModel("Tamil", "ta"),
  // LanguageModel("Spanish", "es"),
  // LanguageModel("Marathi", "mr"),
  // LanguageModel("Russian", "ru"),
  // LanguageModel("Hindi", "hi"),
  // LanguageModel("French", "fr"),
];

class LanguageModel {
  LanguageModel(
    this.language,
    this.symbol,
    this.symbol2,
  );

  String language;
  String symbol;
  String symbol2;
}
