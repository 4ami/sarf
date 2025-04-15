part of '../app_router.dart';

class _LoginRoute extends _BaseRoute {
  const _LoginRoute();

  @override
  GoRoute get route {
    return GoRoute(
      path: ApplicationPaths.login.path,
      name: ApplicationPaths.login.name,
      redirect: redirect,
      pageBuilder: (context, state) {
        context.read<AuthBloc>().add(const SwitchToLoginEvent());
        return MaterialPage(child: Login());
      },
    );
  }

  @override
  Future<String?> redirect(BuildContext context, GoRouterState state) async =>
      null;
}
