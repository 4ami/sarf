part of 'preferences_lib.dart';

final Map<UserPreferences, String> _appPreferencesKeys = {
  UserPreferences.lang: 'language',
  UserPreferences.themeMode: 'theme_mode'
};

final class PreferencesController {
  const PreferencesController._();

  static final PreferencesController _instance = PreferencesController._();

  static PreferencesController get instance => _instance;

  Future<T?> read<T extends Object>(UserPreferences preference) async {
    if (_appPreferencesKeys[preference] == null) return null;

    SharedPreferencesWithCache pref = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );

    log(
      'Get Preference: ${_appPreferencesKeys[preference] ?? 'null'}',
      name: 'Preferences Controller',
    );

    return pref.get(_appPreferencesKeys[preference]!) as T?;
  }

  Future<bool> writeBool(UserPreferences k, bool v) async {
    if (_appPreferencesKeys[k] == null) return false;
    SharedPreferencesWithCache pref = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );

    await pref.setBool(_appPreferencesKeys[k]!, v);
    log(
      'Preference: ${_appPreferencesKeys[k]} set to: $v',
      name: 'Preferences Controller',
    );
    return true;
  }

  Future<bool> writeString(UserPreferences k, String v) async {
    if (_appPreferencesKeys[k] == null) return false;
    SharedPreferencesWithCache pref = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );

    await pref.setString(_appPreferencesKeys[k]!, v);
    log(
      'Preference: ${_appPreferencesKeys[k]} set to: $v',
      name: 'Preferences Controller',
    );
    return true;
  }
}
