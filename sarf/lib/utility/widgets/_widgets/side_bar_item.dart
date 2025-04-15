part of '../shared_widgets.dart';

class SidebarItem {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final int index;

  const SidebarItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
