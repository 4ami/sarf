part of '../../expenses_lib.dart';

class _InfoCard extends StatefulWidget {
  final String icon;
  final String label;
  final String value;
  final double total;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.total,
  });

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
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
          color: isHover ? Colors.black.withValues(alpha: .1) : null,
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
              '${widget.value}%',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.total.toStringAsFixed(2)} ريال',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
