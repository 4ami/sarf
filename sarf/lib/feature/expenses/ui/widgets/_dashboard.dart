part of '../../expenses_lib.dart';

class _Dashboard extends StatefulWidget {
  const _Dashboard();

  @override
  State<_Dashboard> createState() => __DashboardState();
}

class __DashboardState extends State<_Dashboard> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SpendingState state = context.watch<SpendingsBloc>().state;
    return GradientScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.categories.isNotEmpty)
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .5,
                  child: _SpendingPie(),
                ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomField(
                    labelKey: context.translate(key: 'add_expense_field_label'),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: null,
                    label: Text(
                      context.translate(key: 'add_new_expense_button'),
                    ),
                  ),
                ],
              ),

              Padding(padding: const EdgeInsets.symmetric(vertical: 25)),
              Text(
                context.translate(key: 'dashboard_budget_spending_title'),
                style: context.h3,
              ),
              if (state.categories.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 25,
                    children: List.generate(state.categories.length, (i) {
                      double total =
                          state.weeklyExpenses.isEmpty
                              ? 0
                              : state.weeklyExpenses
                                  .where(
                                    (ex) =>
                                        state.categories[i].id == ex.category,
                                  )
                                  .first
                                  .total;
                      return _InfoCard(
                        icon: state.categories[i].icon,
                        label: state.categories[i].labelKey,
                        value: '0',
                        total: total,
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
