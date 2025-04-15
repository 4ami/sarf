part of '../app_router.dart';

final class _RegisterRoute extends _BaseRoute {
  const _RegisterRoute();

  @override
  GoRoute get route {
    return GoRoute(
      path: ApplicationPaths.register.path,
      name: ApplicationPaths.register.name,
      redirect: redirect,
      pageBuilder: (context, state) {
        context.read<AuthBloc>().add(const SwitchToRegisterEvent());
        return MaterialPage(child: Register());
      },
    );
  }

  @override
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    return null;
  }
}
