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

class FailedSpendingService extends SpendingsEvent {
  const FailedSpendingService({required super.message});
}

class TriggerGetCategoriesEvent extends SpendingsEvent {
  const TriggerGetCategoriesEvent();
}

class TriggerGetTotalSpendingsEvent extends SpendingsEvent {
  const TriggerGetTotalSpendingsEvent();
}
