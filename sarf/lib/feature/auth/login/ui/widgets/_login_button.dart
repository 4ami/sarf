part of '../../login_lib.dart';

class _Button extends StatefulWidget {
  const _Button._internal({
    required this.onPressed,
    required this.labelKey,
    this.style,
  });

  final void Function()? onPressed;
  final String labelKey;
  final ButtonStyle Function(BuildContext)? style;

  @override
  State<_Button> createState() => _ButtonState();

  factory _Button.login({required void Function()? onPressed}) {
    return _Button._internal(onPressed: onPressed, labelKey: 'sign_in_button');
  }

  factory _Button.createAccount({required void Function()? onPressed}) {
    return _Button._internal(
      onPressed: onPressed,
      labelKey: 'create_account',
      style:
          (context) => _buttonStyle.copyWith(
            backgroundColor: WidgetStatePropertyAll(
              context.onPrimaryFixedVariant,
            ),
          ),
    );
  }
}

class _ButtonState extends State<_Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: widget.style?.call(context) ?? _buttonStyle,
      onPressed: widget.onPressed,
      child: Text(
        context.translate(key: widget.labelKey),
        style: context.titleLarge!.copyWith(color: Colors.white),
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
