part of '../../register_lib.dart';

class _RegisterFormContainer extends StatefulWidget {
  const _RegisterFormContainer();

  @override
  State<_RegisterFormContainer> createState() => __RegisterFormContainerState();
}

class __RegisterFormContainerState extends State<_RegisterFormContainer> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  void Function()? get registerButton {
    var state = context.watch<AuthBloc>().state;
    if (state.event is! PendingAuthService) {
      return () {
        AuthRegisterState registerState =
            context.read<AuthBloc>().state as AuthRegisterState;
        if (registerState.password == registerState.confirmPassword) {
          context.read<AuthBloc>().add(const TriggerRegister());
        }
      };
    }
    return null;
  }

  void Function()? get goLoginButton {
    var state = context.watch<AuthBloc>().state;
    if (state.event is! PendingAuthService) {
      return () => context.go(ApplicationPaths.login.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.inversePrimary, context.surface],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.translate(key: 'register_form_title'),
              style: context.h3,
            ),
            SizedBox(height: 40),
            CustomField.fullName(
              context,
              onChanged: (name) {
                context.read<AuthBloc>().add(NameChanged(fullName: name ?? ''));
              },
            ),
            SizedBox(height: 30),
            CustomField.email(
              onChanged: (email) {
                context.read<AuthBloc>().add(EmailChanged(email: email ?? ''));
              },
            ),
            SizedBox(height: 30),
            CustomField.password(
              onChanged: (password) {
                context.read<AuthBloc>().add(
                  PasswordChanged(password: password ?? ''),
                );
              },
            ),
            SizedBox(height: 30),
            CustomField.password(
              labelKey: 'confirm_password_label',
              validator: FieldsValidator.confirmPassword,
              onChanged: (confirmPassword) {
                context.read<AuthBloc>().add(
                  ConfirmPasswordChanged(password: confirmPassword ?? ''),
                );
              },
            ),
            SizedBox(height: 50),
            _RegisterSubmitButton.build(onPressed: registerButton),
            SizedBox(height: 20),
            TextButton(
              onPressed: goLoginButton,
              child: Text(context.translate(key: 'already_have_account')),
            ),
          ],
        ),
      ),
    );
  }
}
