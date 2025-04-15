part of 'theme_lib.dart';

/// [AppTheme] singleton class
final class AppTheme {
  const AppTheme._();

  /// [_instance] holds single instance of [AppTheme] which initalized
  /// one time.
  static final AppTheme _instance = AppTheme._();

  /// [instance] provides global access to [AppTheme] instance
  static AppTheme get instance => _instance;

  /// [lightMode] getter returns [ThemeData] with light theme.
  ThemeData lightMode(String fontFamily) {    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xff4857FC),
        brightness: Brightness.light,
      ),
      brightness: Brightness.light,
      fontFamily: fontFamily,
    );
  }

  /// [darkMode] getter returns [ThemeData] with dark theme.
  ThemeData darkMode(String fontFamily) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xff4857FC),
        brightness: Brightness.dark,
      ),
      brightness: Brightness.dark,
      fontFamily: fontFamily,
    );
  }
}
