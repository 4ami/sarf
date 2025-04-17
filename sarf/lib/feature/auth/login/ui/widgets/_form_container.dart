part of '../../login_lib.dart';

class _FormContainer extends StatefulWidget {
  const _FormContainer();

  @override
  State<_FormContainer> createState() => __FormContainerState();
}

class __FormContainerState extends State<_FormContainer> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void Function()? get _loginButton {
    var state = context.watch<AuthBloc>().state;
    if (state.event is! PendingAuthService) {
      return () {
        if (_form.currentState?.validate() == true) {
          context.read<AuthBloc>().add(const TriggerLogin());
        }
      };
    }
    return null;
  }

  void Function()? get _createButton {
    var state = context.watch<AuthBloc>().state;
    if (state.event is! PendingAuthService) {
      return () => context.go(ApplicationPaths.register.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.inversePrimary.withValues(alpha: .7),
            context.surface.withValues(alpha: .7),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.translate(key: 'sign_in_form_title'),
                style: context.h3,
              ),
              SizedBox(height: 50),
              CustomField.email(
                onChanged: (p0) {
                  context.read<AuthBloc>().add(EmailChanged(email: p0 ?? ''));
                },
              ),
              SizedBox(height: 40),
              CustomField.password(
                onChanged: (p0) {
                  context.read<AuthBloc>().add(
                    PasswordChanged(password: p0 ?? ''),
                  );
                },
              ),
              SizedBox(height: 80),
              _Button.login(onPressed: _loginButton),
              SizedBox(height: 30),
              _Button.createAccount(onPressed: _createButton),
            ],
          ),
        ),
      ),
    );
  }
}
