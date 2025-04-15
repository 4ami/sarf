part of '../../expenses_lib.dart';

class _Badge extends StatelessWidget {
  const _Badge({
    required this.asset,
    required this.size,
    required this.borderColor,
  });
  final String asset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,

      decoration: BoxDecoration(
        color: context.surfaceContainerLowest,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(asset, color: context.onPrimaryContainer),
      ),
    );
  }
}
