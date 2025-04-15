part of 'models.dart';

final class Category {
  const Category({
    required this.id,
    required this.labelKey,
    required this.icon,
    this.good = false,
  });
  final int id;
  final String labelKey, icon;
  final bool good;

  factory Category.fromJSON(dynamic obj) {
    return Category(
      id: obj['id'] ?? -1,
      labelKey: obj['name'] ?? '',
      icon: obj['stored_icon_path'] ?? '',
      good: obj['is_good'] ?? false,
    );
  }
}
