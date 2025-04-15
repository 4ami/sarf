part of '../../expenses_lib.dart';

class _SpendingPie extends StatefulWidget {
  const _SpendingPie();

  @override
  State<_SpendingPie> createState() => __SpendingPieState();
}

class __SpendingPieState extends State<_SpendingPie> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SpendingState state = context.read<SpendingsBloc>().state;
    return AspectRatio(
      aspectRatio: 1.6,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback:
                        state.weeklyExpenses.isNotEmpty ? _touchCallback : null,
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  sections:
                      state.weeklyExpenses.isEmpty
                          ? _buildEmpty()
                          : _buildSections(),
                ),
              ),

              Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
                  child: Transform.rotate(
                    angle: -.30,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 25,
                        bottom: 25,
                      ),
                      decoration: BoxDecoration(
                        color: context.surfaceContainerHigh.withValues(
                          alpha: .5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        context.translate(key: 'track_your_expenses_message'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _touchCallback(FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
    setState(() {
      if (!event.isInterestedForInteractions ||
          pieTouchResponse == null ||
          pieTouchResponse.touchedSection == null) {
        touchedIndex = -1;
        return;
      }
      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    });
  }

  List<PieChartSectionData> _buildSections() {
    SpendingState state = context.read<SpendingsBloc>().state;
    List<Category> categories = state.categories;

    return List.generate(categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      var spending = state.weeklyExpenses.where(
        (e) => e.category == categories[i].id,
      );

      double total = spending.isEmpty ? 0 : spending.first.total;

      List<Color> colors = [
        Colors.deepPurple.withValues(alpha: .8),
        Colors.deepPurple.withValues(alpha: .4),
        Colors.deepPurple.withValues(alpha: .3),
        Colors.deepPurple.withValues(alpha: .7),
        Colors.deepPurple.withValues(alpha: .5),
      ];

      return PieChartSectionData(
        color: colors[i],
        value: total,
        title: context.translate(key: categories[i].labelKey),
        radius: radius,
        titleStyle: context.titleLarge!.copyWith(
          shadows: shadows,
          fontSize: fontSize,
        ),
        badgeWidget: _Badge(
          asset: categories[i].icon,
          size: widgetSize,
          borderColor: Colors.black26,
        ),
        badgePositionPercentageOffset: 1.1,
      );
    });
  }

  List<PieChartSectionData> _buildEmpty() {
    SpendingState state = context.read<SpendingsBloc>().state;
    List<Category> categories = state.categories;

    var randoms = List.generate(
      categories.length,
      (i) => Random().nextDouble(),
    );

    return List.generate(categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      List<Color> colors = [
        Colors.deepPurple.withValues(alpha: .8),
        Colors.deepPurple.withValues(alpha: .4),
        Colors.deepPurple.withValues(alpha: .3),
        Colors.deepPurple.withValues(alpha: .7),
        Colors.deepPurple.withValues(alpha: .5),
      ];

      return PieChartSectionData(
        color: colors[i],
        value: randoms[i],
        title: context.translate(key: categories[i].labelKey),
        radius: radius,
        titleStyle: context.titleLarge!.copyWith(
          shadows: shadows,
          fontSize: fontSize,
        ),
        badgeWidget: _Badge(
          asset: categories[i].icon,
          size: widgetSize,
          borderColor: Colors.black26,
        ),
        badgePositionPercentageOffset: 1.1,
      );
    });
  }
}
