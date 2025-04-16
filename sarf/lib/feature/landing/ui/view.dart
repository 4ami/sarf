part of '../landing.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        primary: true,
        leading: Image.asset(AppAssets.assets.logoIcon),
        leadingWidth: 100,
        title: Text(context.translate(key: "app_name"), style: context.h3),
        actions: [_StartNow(), LanguageSwitcher(), ThemeSwitcher()],
        forceMaterialTransparency: true,
        toolbarHeight: 150,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [_TopSection()],
          ),
        ),
      ),
    );
  }
}
