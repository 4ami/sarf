part of '../landing.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return GradientScaffold(
      appBar: AppBar(
        primary: true,
        leading: Image.asset(
          AppAssets.assets.logoIcon,
          scale: width <= 700 ? 1.5 : null,
        ),
        leadingWidth: 100,
        title: Text(
          context.translate(key: "app_name"),
          style: width > 700 ? context.h3 : context.titleSmall,
        ),
        actions: [
          if (width > 700) _StartNow(),
          LanguageSwitcher(),
          ThemeSwitcher(),
        ],
        forceMaterialTransparency: true,
        toolbarHeight: 150,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _TopSection(),
              if (width <= 700)
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: _StartNow(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
