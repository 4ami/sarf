part of '../app_router.dart';

class _LandingRoute extends _BaseRoute {
  const _LandingRoute();

  @override
  GoRoute get route {
    return GoRoute(
      path: ApplicationPaths.landing.path,
      name: ApplicationPaths.landing.name,
      redirect: redirect,
      pageBuilder: (context, state) {
        return MaterialPage(child: Landing());
      },
    );
  }

  @override
  Future<String?> redirect(BuildContext context, GoRouterState state) async =>
      null;
}
