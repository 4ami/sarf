part of '../repository_lib.dart';

final class RangeTotalExpensesUseCase {
  RangeTotalExpensesUseCase();

  final SpendingsServices _repo = SpendingsServices();

  String _formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Future<TotalSpendingsResponse> weeklyExpenses({required String token}) async {
    DateTime date = DateTime.now();
    TotalExpensesRequest request = TotalExpensesRequest(
      fromDate: _formatDate(date),
      toDate: _formatDate(date.subtract(const Duration(days: 7))),
    );

    return await _repo.weeklyExpenses(request: request, token: token);
  }
}
