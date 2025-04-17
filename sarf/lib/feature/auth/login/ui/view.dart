part of '../login_lib.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool errorAppear = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.event is PendingAuthService) {
          context.showLoader();
          setState(() {
            errorAppear = false;
          });
          return;
        }

        if (state.event is SuccessAuthService) {
          context.loaderDispose();
          context.go(ApplicationPaths.expenses.path);
          return;
        }
        if (state.event is FailedAuthService) {
          context.loaderDispose();
          if (!errorAppear) {
            context.errorToast(
              title: context.translate(key: 'error_notification_title'),
              description: state.event.message,
            );
            setState(() {
              errorAppear = true;
            });
          }
          return;
        }
      },
      child: GradientScaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: height * .15,
                right: width / 3,
                left: -(width / 3),
                child: Transform.rotate(
                  angle: -.25,
                  child: Image.asset(AppAssets.assets.increaseBudget, scale: 5),
                ),
              ),
              Positioned(
                bottom: height * .1,
                right: -(width / 3),
                left: (width / 3),
                child: Transform.rotate(
                  angle: .5,
                  child: Image.asset(AppAssets.assets.moneyBag, scale: 4),
                ),
              ),
              _FormContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
