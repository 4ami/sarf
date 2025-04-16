part of 'bloc.dart';

sealed class SpendingsEvent {
  const SpendingsEvent({this.message = ''});
  final String message;
}

class InitialSpendingEvent extends SpendingsEvent {
  const InitialSpendingEvent();
}

class PendingSpendingService extends SpendingsEvent {
  const PendingSpendingService();
}

class SuccessSpendingService extends SpendingsEvent {
  const SuccessSpendingService();
}

class ExpenseAddedSuccessfully extends SpendingsEvent {
  const ExpenseAddedSuccessfully();
}

class FailedSpendingService extends SpendingsEvent {
  const FailedSpendingService({required super.message});
}

class TriggerGetCategoriesEvent extends SpendingsEvent {
  const TriggerGetCategoriesEvent();
}

class TriggerGetTotalSpendingsEvent extends SpendingsEvent {
  const TriggerGetTotalSpendingsEvent();
}

class TriggerAddNewExpenses extends SpendingsEvent {
  const TriggerAddNewExpenses({required this.amount, required this.category});
  final double amount;
  final int category;
}


class StoreBudgetBending extends SpendingsEvent {
  const StoreBudgetBending();
}

class StoreBudgetFailed extends SpendingsEvent {
  const StoreBudgetFailed();
}

class StoreBudgetSuccess extends SpendingsEvent {
  const StoreBudgetSuccess();
}

class TriggerStoreBudget extends SpendingsEvent {
  const TriggerStoreBudget({required this.budget});
  final double budget;
}
