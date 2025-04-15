part of '../app_router.dart';

abstract class _BaseRoute {
  const _BaseRoute();

  GoRoute get route;

  Future<String?> redirect(BuildContext context, GoRouterState state);
}