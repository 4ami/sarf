part of 'repository_lib.dart';

abstract interface class SpendingRepo {
  const SpendingRepo();

  Future<CategoriesResponse> fetchCategories({required String token});
  Future<TotalSpendingsResponse> weeklyExpenses({
    required TotalExpensesRequest request,
    required String token,
  });

  Future<NewExpenseResponse> addExpense({
    required NewExpenseRequest request,
    required String token,
  });
}

final class SpendingsServices extends SpendingRepo {
  SpendingsServices();

  final HttpClient _client = HttpClient();

  @override
  Future<CategoriesResponse> fetchCategories({required String token}) async {
    return await _client.get(
      endpoint: CloudSource.getCategories,
      parser: (obj) => CategoriesResponse.fromJSON(obj),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  @override
  Future<TotalSpendingsResponse> weeklyExpenses({
    required TotalExpensesRequest request,
    required String token,
  }) async {
    return await _client.post(
      body: request,
      endpoint: CloudSource.expenseRange,
      parser: (res) => TotalSpendingsResponse.fromJSON(res),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  @override
  Future<NewExpenseResponse> addExpense({
    required NewExpenseRequest request,
    required String token,
  }) async {
    return await _client.post(
      body: request,
      endpoint: CloudSource.addExpense,
      parser: (res) => NewExpenseResponse.fromJSON(res),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
