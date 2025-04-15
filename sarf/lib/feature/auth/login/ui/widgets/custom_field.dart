part of '../../login_lib.dart';

class CustomField extends StatefulWidget {
  const CustomField._({
    this.width,
    this.height,
    this.onChanged,
    this.validator,
    required this.labelKey,
    this.hint,
    this.obsecure = false,
    this.direction,
    this.hintDirection,
    this.keyboardType,
  });

  const CustomField({
    super.key,
    this.width,
    this.height,
    this.onChanged,
    this.validator,
    required this.labelKey,
    this.hint,
    this.obsecure = false,
    this.direction,
    this.hintDirection,
    this.keyboardType
  });

  final double? width, height;
  final void Function(String?)? onChanged;
  final String? Function(String?, BuildContext)? validator;

  final String labelKey;
  final String? hint;

  final TextDirection? direction, hintDirection;

  final bool obsecure;

  final TextInputType? keyboardType;

  factory CustomField.fromSize({
    required String labelKey,
    String? hint,
    required double width,
    required double height,
    TextDirection? direction,
    TextDirection? hintDirection,
    void Function(String?)? onChanged,
    String? Function(String?, BuildContext)? validator,
  }) {
    return CustomField._(
      labelKey: labelKey,
      hint: hint,
      height: height,
      width: width,
      onChanged: onChanged,
      validator: validator,
      hintDirection: hintDirection,
      direction: direction,
    );
  }

  factory CustomField.password({
    String? labelKey,
    void Function(String?)? onChanged,
    String? Function(String?, BuildContext)? validator,
  }) {
    return CustomField._(
      labelKey: labelKey ?? 'password_field_label',
      hint: '**********',
      onChanged: onChanged,
      validator: validator ?? FieldsValidator.password,
      obsecure: true,
      direction: TextDirection.ltr,
      hintDirection: TextDirection.ltr,
    );
  }

  factory CustomField.email({void Function(String?)? onChanged, TextInputType? keyboardType}) {
    return CustomField._(
      labelKey: 'email_field_label',
      hint: 'email@sarf.com',
      onChanged: onChanged,
      validator: FieldsValidator.email,
      direction: TextDirection.ltr,
      hintDirection: TextDirection.ltr,
      keyboardType: keyboardType,
    );
  }

  factory CustomField.fullName(
    BuildContext context, {
    void Function(String?)? onChanged,
  }) {
    return CustomField._(
      labelKey: 'full_name_field_label',
      hint: context.translate(key: 'full_name_field_hint'),
      onChanged: onChanged,
      validator: FieldsValidator.fullName,
    );
  }

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 360,
      height: widget.height,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.obsecure,
        autovalidateMode: AutovalidateMode.onUnfocus,
        validator:
            widget.validator != null
                ? (v) => widget.validator!(v, context)
                : null,
        onChanged: widget.onChanged,
        textDirection: widget.direction,
        decoration: InputDecoration(
          labelStyle: context.titleLarge,
          border: _border,
          enabledBorder: _border,
          label: Text(context.translate(key: widget.labelKey)),
          hintText: widget.hint,
          hintTextDirection: widget.hintDirection,
        ),
      ),
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: context.primary, width: 2.5),
    );
  }
}
