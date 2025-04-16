part of '../app_router.dart';

final class _ExpensesRoute extends _BaseRoute {
  const _ExpensesRoute();

  @override
  GoRoute get route {
    return GoRoute(
      path: ApplicationPaths.expenses.path,
      name: ApplicationPaths.expenses.name,
      redirect: redirect,
      pageBuilder: (context, state) {
        context.read<AuthBloc>().add(const Authenticated());

        return MaterialPage(
          child: BlocProvider<SpendingsBloc>(
            create:
                (context) =>
                    SpendingsBloc()
                      ..add(TriggerGetCategoriesEvent())
                      ..add(TriggerGetTotalSpendingsEvent()),
            child: const ExpensesHome(),
          ),
        );
      },
    );
  }

  @override
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    return await _checkAuthenticity() ? null : ApplicationPaths.login.path;
  }

  Future<bool> _checkAuthenticity() async {
    String? token = await SS.instance.read('token');
    if (token == null || token.isEmpty) return false;
    if (JwtDecoder.tryDecode(token) == null) return false;
    if (JwtDecoder.isExpired(token)) return false;
    return true;
  }
}
