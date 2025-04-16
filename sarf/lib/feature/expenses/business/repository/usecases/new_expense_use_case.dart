part of '../repository_lib.dart';

class NewExpenseUseCase {
  NewExpenseUseCase();

  final SpendingsServices _repo = SpendingsServices();

  Future<NewExpenseResponse> execute({
    required NewExpenseRequest request,
    required String token,
  }) async {
    return await _repo.addExpense(request: request, token: token);
  }
}
