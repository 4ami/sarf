part of '../shared_widgets.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _turnAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _turnAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeModeCubit>().isLight;
    return GestureDetector(
      onTap: _toggleCallback,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 25, right: 25),
        decoration: _containerDecoration,
        child: _animatedIcon(isLight),
      ),
    );
  }

  AnimatedSwitcher _animatedIcon(bool isLight) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (child, animation) {
        final slideIn = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);

        final slideOut = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-.4, 0),
        ).animate(animation);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: child.key == ValueKey(isLight) ? slideIn : slideOut,
            child: child,
          ),
        );
      },
      child: RotationTransition(
        key: ValueKey(isLight),
        turns: _turnAnimation,
        child: Icon(
          isLight ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCallback() {
    _controller.forward(from: 0);
    context.read<ThemeModeCubit>().toggle();
  }

  BoxDecoration get _containerDecoration {
    return BoxDecoration(
      color: context.primaryContainer,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: context.inversePrimary.withValues(alpha: .7),
          offset: const Offset(5, 5),
          blurRadius: 15,
          spreadRadius: -5,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: .3),
          offset: -const Offset(5, 5),
          spreadRadius: -25,
          blurRadius: 35,
        ),
      ],
    );
  }
}
