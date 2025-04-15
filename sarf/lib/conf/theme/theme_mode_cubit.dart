part of 'theme_lib.dart';

final class ThemeModeCubit extends Cubit<ThemeMode> {
  ThemeModeCubit() : super(ThemeMode.system) {
    call();
  }

  void call() async {
    String? mode = await PreferencesController.instance.read<String>(
      UserPreferences.themeMode,
    );

    if (mode == null) {
      emit(ThemeMode.system);
      return;
    }

    log('Prefered Mode: $mode', name: 'Theme Cubit');

    emit(mode == 'dark' ? ThemeMode.dark : ThemeMode.light);
  }

  /// [toggle] function that switch the current theme
  /// with the opposite value.
  /// example: dark -> light // or // light -> dark

  Future<bool> _store(String mode) async {
    return await PreferencesController.instance.writeString(
      UserPreferences.themeMode,
      mode,
    );
  }

  void toggle() async {
    log('Mode: $state', name: 'ThemeCubit');
    switch (state) {
      case ThemeMode.dark:
        {
          emit(ThemeMode.light);
          await _store('light');
          return;
        }
      case ThemeMode.light:
        {
          emit(ThemeMode.dark);
          await _store('dark');
          return;
        }

      case ThemeMode.system:
        {
          Brightness brightness =
              WidgetsBinding.instance.platformDispatcher.platformBrightness;
          if (brightness == Brightness.light) {
            emit(ThemeMode.dark);
            await _store('dark');
          } else {
            emit(ThemeMode.light);
            await _store('light');
          }
          return;
        }
    }
  }

  /// [setDarkMode] function that set the theme mode to dark.
  void setDarkMode() async {
    emit(ThemeMode.dark);
    await _store('dark');
  }

  /// [setLightMode] function that set the theme mode to light.
  void setLightMode() async {
    emit(ThemeMode.light);
    await _store('light');
  }

  /// [isLight] is a [bool] getter that return boolean value
  /// results of logical operation which check if the current [state]
  /// is equal to [ThemeMode.light]
  bool get isLight => state == ThemeMode.light;
}
