part of 'bloc.dart';

class SpendingState {
  const SpendingState({
    this.categories = const [],
    this.event = const InitialSpendingEvent(),
    this.weeklyExpenses = const [],
  });

  final SpendingsEvent event;

  final List<Category> categories;

  final List<CategoryTotalSpending> weeklyExpenses;

  SpendingState copyWith({
    SpendingsEvent? event,
    List<Category>? categories,
    List<CategoryTotalSpending>? weeklyExpenses,
  }) {
    return SpendingState(
      event: event ?? this.event,
      categories: categories ?? this.categories,
      weeklyExpenses: weeklyExpenses ?? this.weeklyExpenses,
    );
  }
}
