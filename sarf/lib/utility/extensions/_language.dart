part of 'extensions_lib.dart';

extension LanguageExtension on BuildContext {
  String translate({required String key}) {
    return AppLanguage.of(this).grep(key: key);
  }
}