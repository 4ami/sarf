part of '../../expenses_lib.dart';

class _Dashboard extends StatefulWidget {
  const _Dashboard();

  @override
  State<_Dashboard> createState() => __DashboardState();
}

class __DashboardState extends State<_Dashboard> {
  late PageController _pageController;

  bool _hasShown = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SpendingState state = context.watch<SpendingsBloc>().state;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_hasShown) return;
      for (int i = 0; i < state.categories.length; i++) {
        double total = 0;

        var matched = state.weeklyExpenses.where(
          (ex) => state.categories[i].id == ex.category,
        );

        if (matched.isNotEmpty) {
          total = matched.first.total;
        }

        double spendingPercentage =
            state.budget == 0 ? 0 : ((total / state.budget) * 100);

        if (spendingPercentage >= 80 && !state.categories[i].good) {
          String category = context.translate(
            key: state.categories[i].labelKey,
          );
          String pre = context.translate(
            key: 'warning_80_notification_pre_description',
          );
          String post = context.translate(
            key: 'warning_80_notification_post_description',
          );
          String desc = '$pre $category $post';
          context.warningToast(
            title: context.translate(key: "warning_80_notification_label"),
            description: desc,
            categoryIcon: state.categories[i].icon,
          );
        }

        if (spendingPercentage >= 80 && state.categories[i].good) {
          String category = context.translate(
            key: state.categories[i].labelKey,
          );
          String pre = context.translate(
            key: 'good_80_notification_pre_description',
          );
          String post = context.translate(
            key: 'good_80_notification_post_description',
          );
          String desc = '$pre $category $post';
          context.successToast(
            title: context.translate(key: 'good_80_notification_label'),
            description: desc,
          );
        }
      }

      _hasShown = true;
    });
    return GradientScaffold(
      appBar: AppBar(
        primary: true,
        leading: Image.asset(AppAssets.assets.logoIcon),
        leadingWidth: 100,
        title: Text(context.translate(key: "app_name"), style: context.h3),
        actions: [LanguageSwitcher(), ThemeSwitcher()],
        forceMaterialTransparency: true,
        toolbarHeight: 150,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.categories.isNotEmpty)
                Center(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * .5,
                    child: _SpendingPie(),
                  ),
                ),

              //New expense
              Center(child: _NewExpenseForm()),
              const SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  context.translate(key: 'dashboard_budget_spending_title'),
                  style: context.h3,
                ),
              ),
              if (state.categories.isNotEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runSpacing: 25,
                      spacing: 25,
                      children: cards(state),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> cards(SpendingState state) {
    return List.generate(state.categories.length, (i) {
      double total = 0;

      var matched = state.weeklyExpenses.where(
        (ex) => state.categories[i].id == ex.category,
      );

      if (matched.isNotEmpty) {
        total = matched.first.total;
      }

      double spendingPercentage =
          state.budget == 0 ? 0 : ((total / state.budget) * 100);

      return _InfoCard(
        icon: state.categories[i].icon,
        label: state.categories[i].labelKey,
        value: spendingPercentage,
        total: total,
        isGood: state.categories[i].good,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
