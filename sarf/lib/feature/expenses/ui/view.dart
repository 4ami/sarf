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
            _ExpensesSideBar(
              selectedIndex: index,
              onPush: _onPush,
              onTap: _onTap,
            ),

            Expanded(
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [_Dashboard(), Budget()],
              ),
            ),
          ],
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
