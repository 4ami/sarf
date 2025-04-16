part of 'bloc.dart';

class SpendingState {
  const SpendingState({
    this.categories = const [],
    this.event = const InitialSpendingEvent(),
    this.weeklyExpenses = const [],
    this.budget = 0,
  });

  final SpendingsEvent event;

  final List<Category> categories;

  final List<CategoryTotalSpending> weeklyExpenses;

  final double budget;

  SpendingState copyWith({
    SpendingsEvent? event,
    List<Category>? categories,
    List<CategoryTotalSpending>? weeklyExpenses,
    double? budget
  }) {
    return SpendingState(
      event: event ?? this.event,
      categories: categories ?? this.categories,
      weeklyExpenses: weeklyExpenses ?? this.weeklyExpenses,
      budget: budget ?? this.budget
    );
  }
}
