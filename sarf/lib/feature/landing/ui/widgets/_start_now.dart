part of '../../landing.dart';

class _StartNow extends StatelessWidget {
  const _StartNow();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xff4857FC)),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
        shape: WidgetStatePropertyAll(StadiumBorder()),
      ),
      onPressed: () => context.go(ApplicationPaths.login.path),
      child: Text(context.translate(key: 'start_now')),
    );
  }
}
