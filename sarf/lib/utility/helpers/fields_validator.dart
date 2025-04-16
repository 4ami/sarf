part of 'helpers_lib.dart';

final class FieldsValidator {
  static String? email(String? v, BuildContext c) {
    if (v == null || v.isEmpty) return c.translate(key: 'required_field');

    final valid = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!valid.hasMatch(v)) return c.translate(key: 'invalid_email');
    return null;
  }

  static String? password(String? v, BuildContext c) {
    if (v == null || v.isEmpty) return c.translate(key: 'required_field');

    //length policy
    if (v.length < 8) return c.translate(key: 'violated_password_policy_1');

    //alphabet policy
    final alphabet = RegExp(r'[a-zA-Z]');
    if (!alphabet.hasMatch(v)) {
      return c.translate(key: 'violated_password_policy_2');
    }

    //Upper case policy
    final capital = RegExp(r'[A-Z]');
    if (!capital.hasMatch(v)) {
      return c.translate(key: 'violated_password_policy_3');
    }

    //Numbers policy
    final nums = RegExp(r'[0-9]');
    if (!nums.hasMatch(v)) {
      return c.translate(key: 'violated_password_policy_4');
    }

    //Two digits policy
    final twoDig = RegExp(r'(?:.*\d.*\d)');
    if (!twoDig.hasMatch(v)) {
      return c.translate(key: 'violated_password_policy_5');
    }

    //Special policy
    final sp = RegExp(r'[!@#\$%^&*()_+\-=\[\]{};:"\\|,.<>\/?`~]');
    if (!sp.hasMatch(v)) return c.translate(key: 'violated_password_policy_6');

    return null;
  }

  static String? fullName(String? v, BuildContext c) {
    if (v == null || v.isEmpty) return c.translate(key: 'required_field');

    final sp = RegExp(r'[!@#\$%^&*()_+\-=\[\]{};:"\\|,.<>\/?`~]');
    if (sp.hasMatch(v)) return c.translate(key: 'invalid_full_name');

    final nums = RegExp(r'[0-9]');
    if (nums.hasMatch(v)) return c.translate(key: 'numbers_not_allowed');
    return null;
  }

  static String? confirmPassword(String? v, BuildContext c) {
    if (password(v, c) != null) {
      return c.translate(key: 'confirm_password_mismatch');
    }

    String pass = (c.read<AuthBloc>().state as AuthRegisterState).password;

    if (pass != v) return c.translate(key: 'confirm_password_mismatch');

    return null;
  }

  static String? expenseField(String? v, BuildContext c) {
    if (v == null || v.isEmpty) return c.translate(key: 'required_field');

    if (double.tryParse(v) == null) {
      return c.translate(key: 'expense_number_violation');
    }

    final sp = RegExp(r'[!@#\$%^&*()_+\-=\[\]{};:"\\|,.<>\/?`~]');
    if (sp.hasMatch(v)) return c.translate(key: 'invalid_expense_input');

    if (double.parse(v) < 0) {
      return c.translate(key: 'positive_expense_required');
    }

    return null;
  }
}
