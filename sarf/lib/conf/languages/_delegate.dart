part of 'language_lib.dart';

class AppDelegate extends LocalizationsDelegate<AppLanguage> {
  const AppDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLanguage> load(Locale locale) async {
    AppLanguage appLang = AppLanguage(locale: locale);
    await appLang.load();
    return appLang;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLanguage> old) => false;
}
