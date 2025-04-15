part of 'extensions_lib.dart';

extension CustomToasts on BuildContext {
  ToastificationItem errorToast({
    required String title,
    required String description,
  }) {
    return toastification.show(
      autoCloseDuration: const Duration(seconds: 5),
      context: this,
      title: Text(
        title,
        style: titleMedium!.copyWith(
          color: errorColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(description),
      primaryColor: errorColor,
      backgroundColor: errorContainer,
      foregroundColor: errorColor,
      style: ToastificationStyle.flatColored,
      icon: Icon(Icons.error_rounded),
    );
  }
}
