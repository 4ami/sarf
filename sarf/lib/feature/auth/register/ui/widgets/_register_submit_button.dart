part of '../../register_lib.dart';

class _RegisterSubmitButton extends StatefulWidget {
  const _RegisterSubmitButton._internal({
    required this.onPressed,
    required this.labelKey,
    this.style,
  });

  final void Function()? onPressed;
  final String labelKey;
  final ButtonStyle Function(BuildContext)? style;

  factory _RegisterSubmitButton.build({
    required void Function()? onPressed,
    ButtonStyle Function(BuildContext)? style,
  }) {
    return _RegisterSubmitButton._internal(
      onPressed: onPressed,
      labelKey: 'register_button_label',
      style: style,
    );
  }

  @override
  State<_RegisterSubmitButton> createState() => __RegisterSubmitButtonState();
}

class __RegisterSubmitButtonState extends State<_RegisterSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: widget.style?.call(context) ?? _buttonStyle,
      onPressed: widget.onPressed,
      child: Text(
        context.translate(key: widget.labelKey),
        style: context.h5!.copyWith(color: Colors.white),
      ),
    );
  }
}

final ButtonStyle _buttonStyle = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(Color(0xff4857FC)),
  foregroundColor: WidgetStatePropertyAll(Colors.white),
  padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  fixedSize: WidgetStatePropertyAll(Size(350, 60)),
);
