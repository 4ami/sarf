part of 'language_lib.dart';

Locale _default = Locale('en');

class AppLanguageCubit extends Cubit<Locale> {
  AppLanguageCubit() : super(_default) {
    call();
  }

  void call() async {
    String lang =
        (await PreferencesController.instance.read<String>(
          UserPreferences.lang,
        )) ??
        _default.languageCode;
    emit(Locale(lang));

    log('Language on call: ${state.languageCode}', name: 'Language Cubit');
  }

  void toggle() async {
    String cur = '';
    if (state == _default) {
      cur = 'ar';
    } else {
      cur = 'en';
    }
    emit(Locale(cur));
    await PreferencesController.instance.writeString(UserPreferences.lang, cur);
    log('Language: ${state.languageCode}', name: 'Language Cubit');
  }

  void toAR() async {
    emit(Locale('ar'));
    await PreferencesController.instance.writeString(UserPreferences.lang, 'ar');
    log('Language: ${state.languageCode}', name: 'Language Cubit');
  }

  void toEN() async {
    emit(Locale('en'));
    await PreferencesController.instance.writeString(UserPreferences.lang, 'en');
    log('Language: ${state.languageCode}', name: 'Language Cubit');
  }
}