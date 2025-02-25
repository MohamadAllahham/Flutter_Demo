enum Language {
  english(languageCode: 'en'),
  german(languageCode: 'de');

  final String languageCode;
  const Language({
    required this.languageCode,
  });
}
