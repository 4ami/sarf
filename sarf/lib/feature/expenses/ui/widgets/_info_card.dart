part of '../../expenses_lib.dart';

class _InfoCard extends StatefulWidget {
  final String icon;
  final String label;
  final double value;
  final double total;
  final bool isGood;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.total,
    this.isGood = false,
  });

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    bool exceeds80 = widget.value >= 80;

    Color? containerColor() {
      Color warning = Colors.deepOrangeAccent;
      Color good = Colors.lightGreenAccent;
      if (exceeds80) {
        if (isHover) {
          return widget.isGood
              ? good.withValues(alpha: .1)
              : warning.withValues(alpha: .1);
        }
        return widget.isGood
            ? good.withValues(alpha: .3)
            : warning.withValues(alpha: .3);
      }
      return isHover ? Colors.black.withValues(alpha: .1) : null;
    }

    return MouseRegion(
      onEnter: (event) {
        if (isHover) return;
        setState(() {
          isHover = true;
        });
      },

      onExit: (event) {
        if (!isHover) return;

        setState(() {
          isHover = false;
        });
      },
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: containerColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(widget.icon, color: context.primary),
            const SizedBox(height: 12),
            Text(
              context.translate(key: widget.label),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.value.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.total.toStringAsFixed(2)} ${context.translate(key: 'currency_name')}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
