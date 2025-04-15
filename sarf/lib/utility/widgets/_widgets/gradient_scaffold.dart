part of '../shared_widgets.dart';

class GradientScaffold extends StatefulWidget {
  const GradientScaffold({
    super.key,
    this.appBar,
    this.drawer,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.bottomSheet,
  });

  final PreferredSizeWidget? appBar;

  final Widget? body;

  final Widget? drawer;

  final Widget? floatingActionButton;

  final Widget? bottomNavigationBar;

  final Widget? bottomSheet;

  @override
  State<GradientScaffold> createState() => _GradientScaffoldState();
}

class _GradientScaffoldState extends State<GradientScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _graident,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Scaffold(
          key: ValueKey(context.watch<AppLanguageCubit>().state.languageCode),
          backgroundColor: Colors.transparent,
          appBar: widget.appBar,
          drawer: widget.drawer,
          body: widget.body,
          floatingActionButton: widget.floatingActionButton,
          bottomNavigationBar: widget.bottomNavigationBar,
          bottomSheet: widget.bottomSheet,
        ),
      ),
    );
  }

  BoxDecoration get _graident {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [context.inversePrimary, context.surface],
        begin: Alignment.topCenter,
        stops: [0.1, 1],
        end: Alignment.bottomCenter,
      ),
    );
  }
}
