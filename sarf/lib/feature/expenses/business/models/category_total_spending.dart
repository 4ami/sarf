final class CategoryTotalSpending {
  const CategoryTotalSpending({required this.category, required this.total});

  final int category;
  final double total;

  factory CategoryTotalSpending.fromJSON(obj) {
    return CategoryTotalSpending(
      category: obj['category'],
      total: obj['total'],
    );
  }

  CategoryTotalSpending copyWith(double amount){
    return CategoryTotalSpending(category: category, total: (total+amount));
  }
}
