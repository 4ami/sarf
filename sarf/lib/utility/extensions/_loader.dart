part of 'extensions_lib.dart';

extension Loader on BuildContext {
  void showLoader() {
    showDialog(
      context: this,
      builder: (_) => const Loading(),
      barrierDismissible: false,
    );
  }

  void loaderDispose() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
