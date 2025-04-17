part of '../../expenses_lib.dart';

class _ExpensesBottomNavBar extends StatelessWidget {
  const _ExpensesBottomNavBar({
    required this.selectedIndex,
    required this.onTap,
    required this.onPush,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final ValueChanged<String> onPush;

  @override
  Widget build(BuildContext context) {
    final items = [
      _BottomNavItem(
        index: 0,
        icon: Image.asset(
          AppAssets.assets.budgetIcon,
          width: 24,
          color:
              selectedIndex == 0 ? context.primary : context.secondaryFixedDim,
        ),
        label: 'budget_side_bar_label',
        onTap: () => onTap(0),
      ),
      _BottomNavItem(
        index: 1,
        icon: Image.asset(
          AppAssets.assets.dashboardIcon,
          width: 24,
          color:
              selectedIndex == 1 ? context.primary : context.secondaryFixedDim,
        ),
        label: 'dashboard_side_bar_label',
        onTap: () => onTap(1),
      ),
      _BottomNavItem(
        index: 2,
        icon: Icon(Icons.exit_to_app_rounded, color: context.secondaryFixedDim),
        label: 'log_out_button',
        onTap: () => context.read<AuthBloc>().add(const Logout()),
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            items.map((item) => buildBottomNavItem(context, item)).toList(),
      ),
    );
  }

  Widget buildBottomNavItem(BuildContext context, _BottomNavItem item) {
    final isSelected = selectedIndex == item.index;

    return GestureDetector(
      onTap: item.onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          item.icon,
          const SizedBox(height: 4),
          Text(
            context.translate(key: item.label),
            style: context.labelSmall!.copyWith(
              color: isSelected ? context.primary : context.secondaryFixedDim,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem {
  final int index;
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  _BottomNavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
