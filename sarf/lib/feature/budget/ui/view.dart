part of '../budget_lib.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return GradientScaffold(
      appBar: AppBar(
        primary: true,
        leading: Image.asset(AppAssets.assets.logoIcon),
        leadingWidth: 100,
        title: Text(
          context.translate(key: "app_name"),
          style: width > 700 ? context.h3 : context.titleSmall,
        ),
        actions: [LanguageSwitcher(), ThemeSwitcher()],
        forceMaterialTransparency: true,
        toolbarHeight: 150,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            right: width / 3,
            left: -(width / 3),
            child: Transform.rotate(
              angle: -.25,
              child: Image.asset(AppAssets.assets.increaseBudget, scale: 5),
            ),
          ),
          Positioned(
            right: -(width / 3),
            left: (width / 3),
            child: Transform.rotate(
              angle: .5,
              child: Image.asset(AppAssets.assets.moneyBag, scale: 4),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 6),
                  child: _CurrentBudget(),
                ),
                const SizedBox(height: 50),
                _SetBudgetContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
