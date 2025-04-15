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
    return null;
  }
}
