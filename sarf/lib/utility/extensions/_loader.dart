part of 'extensions_lib.dart';

extension Loader on BuildContext {
  static bool _isVisible = false;
  void showLoader() {
    if (_isVisible) return;

    showDialog(
      context: this,
      builder: (_) => const Loading(),
      barrierDismissible: false,
    );
    _isVisible = true;
  }

  void loaderDispose() {
    if (!_isVisible) return;
    Navigator.of(this, rootNavigator: true).pop();
    _isVisible = false;
  }
}
