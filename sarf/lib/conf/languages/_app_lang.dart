part of 'language_lib.dart';

final class AppLanguage {
  const AppLanguage({required this.locale});

  final Locale locale;

  static late Map<String, String> _strings;

  Future<void> load() async {
    String langJson = await rootBundle.loadString(
      'lang/${locale.languageCode}.json',
    );
    Map<String, dynamic> jsonMap = json.decode(langJson);
    _strings = jsonMap.map((k, v) => MapEntry(k, v.toString()));
  }

  String grep({required String key}) => _strings[key] ?? key;

  static AppLanguage of(BuildContext context){
    return Localizations.of(context, AppLanguage)!;
  }
}