part of '../../expenses_lib.dart';

class _ExpensesSideBar extends StatefulWidget {
  const _ExpensesSideBar({
    required this.selectedIndex,
    required this.onPush,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final ValueChanged<String> onPush;

  @override
  State<_ExpensesSideBar> createState() => __ExpensesSideBarState();
}

class __ExpensesSideBarState extends State<_ExpensesSideBar> {
  bool isExpanded = true;
  void toggleSidebar() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      SidebarItem(
        index: 0,
        icon: Image.asset(
          AppAssets.assets.dashboardIcon,
          width: 25,
          color:
              widget.selectedIndex == 0 ? context.onSecondaryContainer : null,
        ),
        label: 'dashboard_side_bar_label',
        onTap: () => widget.onTap(0),
      ),
      SidebarItem(
        index: 1,
        icon: Image.asset(
          AppAssets.assets.budgetIcon,
          width: 25,
          color:
              widget.selectedIndex == 1 ? context.onSecondaryContainer : null,
        ),
        label: 'budget_side_bar_label',
        onTap: () => widget.onTap(1),
      ),
      SidebarItem(
        index: 2,
        icon: Icon(Icons.exit_to_app_rounded),
        label: 'log_out_button',
        onTap: () => context.read<AuthBloc>().add(const Logout()),
      ),
    ];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isExpanded ? 200 : 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.onPrimaryFixed, context.secondaryFixed],
          begin: Alignment.topCenter,
          stops: [0.3, 1],
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: IconButton.filled(
              onPressed: toggleSidebar,
              icon: Icon(
                isExpanded ? Icons.close : Icons.menu,
                color: context.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...items.map((item) => buildSidebarItem(item)),
        ],
      ),
    );
  }

  Widget buildSidebarItem(SidebarItem item) {
    bool isSelected = widget.selectedIndex == item.index;
    Color? color = isSelected ? context.primaryContainer : null;
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          shape: isExpanded ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: isExpanded ? BorderRadius.circular(10) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            item.icon,
            if (isExpanded) const SizedBox(width: 12),
            if (isExpanded)
              Expanded(
                child: Text(
                  overflow: TextOverflow.fade,
                  context.translate(key: item.label),
                  style: context.titleMedium!.copyWith(
                    color:
                        isSelected
                            ? context.onSecondaryContainer
                            : context.secondaryFixedDim,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
