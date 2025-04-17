part of '../expenses_lib.dart';

class ExpensesHome extends StatefulWidget {
  const ExpensesHome({super.key});

  @override
  State<ExpensesHome> createState() => _ExpensesHomeState();
}

class _ExpensesHomeState extends State<ExpensesHome> {
  late PageController _pageController;
  int index = 0;

  void _onTap(int i) {
    setState(() => index = i);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPush(String path) => context.go(path);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return MultiBlocListener(
      listeners: [
        BlocListener<SpendingsBloc, SpendingState>(
          listener: (context, state) {
            if (state.event is PendingSpendingService) {
              context.showLoader();
              return;
            }

            if (state.event is SuccessSpendingService) {
              context.loaderDispose();
              return;
            }

            if (state.event is StoreBudgetBending) {
              context.showLoader();
              return;
            }

            if (state.event is StoreBudgetSuccess) {
              context.loaderDispose();
              return;
            }

            if (state.event is ExpenseAddedSuccessfully) {
              context.loaderDispose();
              context.successToast(
                title: context.translate(key: 'add_expense_success_title'),
                description: context.translate(
                  key: 'add_expense_success_description',
                ),
              );
              return;
            }

            if (state.event is FailedSpendingService) {
              context.loaderDispose();
              context.errorToast(
                title: context.translate(key: 'error_notification_title'),
                description: state.event.message,
              );
              return;
            }
          },
        ),

        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.event is SuccessAuthService) {
              context.go(ApplicationPaths.landing.path);
              return;
            }
          },
        ),
      ],
      child: GradientScaffold(
        body: Row(
          children: [
            if (width > 700)
              _ExpensesSideBar(
                selectedIndex: index,
                onPush: _onPush,
                onTap: _onTap,
              ),

            Expanded(
              child: PageView.builder(
                itemBuilder: (context, i) {
                  return views[i];
                },
                scrollDirection: Axis.vertical,
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: views.length,
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            width <= 700
                ? _ExpensesBottomNavBar(
                  selectedIndex: index,
                  onTap: _onTap,
                  onPush: _onPush,
                )
                : null,
      ),
    );
  }

  List<Widget> views = const [Budget(), _Dashboard()];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
