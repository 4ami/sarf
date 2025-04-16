library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sarf/feature/expenses/business/models/category_total_spending.dart';
import 'package:sarf/feature/expenses/business/models/models.dart';
import 'package:sarf/feature/expenses/business/repository/repository_lib.dart';
import 'package:sarf/local/local_storage.dart';

part 'event.dart';
part 'state.dart';

final class SpendingsBloc extends Bloc<SpendingsEvent, SpendingState> {
  SpendingsBloc() : super(const SpendingState()) {
    _fetchCategories();
    _weeklyExpenses();
    _addExpense();
    _storeBudget();
  }

  String _getError(dynamic error) {
    print(error.toString());
    if (error is ClientException) return 'System Backend offline!';
    if (error is Exception) return error.toString();
    if (error is String) return error;
    return "Unexpected Error";
  }

  void _fetchCategories() {
    CategoriesResponse? handleThen(CategoriesResponse res) {
      if (res.code != 200) throw res.message;
      return res;
    }

    on<TriggerGetCategoriesEvent>((event, emit) async {
      if (state.categories.isNotEmpty) return;

      emit(state.copyWith(event: const PendingSpendingService()));

      bool stored = await SS.instance.isStored(key: 'budget');
      if (stored) {
        double budget = await SS.instance.readBudget();
        emit(state.copyWith(budget: budget));
        print('Budget: $budget');
      }

      String? token = await SS.instance.read('token');

      if (token == null || JwtDecoder.tryDecode(token) == null) {
        emit(
          state.copyWith(
            event: const FailedSpendingService(message: 'Try to re-login'),
          ),
        );
        return;
      }

      FetchCategoriesUseCase useCase = FetchCategoriesUseCase();
      String error = "";

      CategoriesResponse? response = await useCase
          .fetch(token: token)
          .then(handleThen)
          .catchError((er) {
            error = _getError(er);
            return null;
          });

      if (error.isNotEmpty || response == null) {
        emit(state.copyWith(event: FailedSpendingService(message: error)));
        return;
      }

      emit(
        state.copyWith(
          event: const SuccessSpendingService(),
          categories: response.categories,
        ),
      );
    });
  }

  void _weeklyExpenses() {
    TotalSpendingsResponse? handleThen(TotalSpendingsResponse res) {
      if (res.code != 200 && res.code != 404) throw res.message;
      return res;
    }

    on<TriggerGetTotalSpendingsEvent>((event, emit) async {
      if (state.weeklyExpenses.isNotEmpty) return;

      emit(state.copyWith(event: const PendingSpendingService()));

      String? token = await SS.instance.read('token');

      if (token == null || JwtDecoder.tryDecode(token) == null) {
        emit(
          state.copyWith(
            event: const FailedSpendingService(message: 'Try to re-login'),
          ),
        );
        return;
      }

      RangeTotalExpensesUseCase useCase = RangeTotalExpensesUseCase();
      String error = "";

      TotalSpendingsResponse? response = await useCase
          .weeklyExpenses(token: token)
          .then(handleThen)
          .catchError((er) {
            error = _getError(er);
            return null;
          });

      if (error.isNotEmpty || response == null) {
        emit(state.copyWith(event: FailedSpendingService(message: error)));
        return;
      }

      emit(
        state.copyWith(
          event: const SuccessSpendingService(),
          weeklyExpenses: response.totalSpendings,
        ),
      );
    });
  }

  void _addExpense() {
    NewExpenseResponse? handleThen(NewExpenseResponse res) {
      if (res.code != 201) throw res.message;
      return res;
    }

    on<TriggerAddNewExpenses>((event, emit) async {
      emit(state.copyWith(event: const PendingSpendingService()));

      String? token = await SS.instance.read('token');

      if (token == null || JwtDecoder.tryDecode(token) == null) {
        emit(
          state.copyWith(
            event: const FailedSpendingService(message: 'Try to re-login'),
          ),
        );
        return;
      }

      String error = "";
      NewExpenseRequest request = NewExpenseRequest(
        amount: event.amount,
        category: event.category,
      );

      NewExpenseUseCase useCase = NewExpenseUseCase();

      NewExpenseResponse? response = await useCase
          .execute(request: request, token: token)
          .then(handleThen)
          .catchError((er) {
            error = _getError(er);
            return null;
          });

      if (error.isNotEmpty || response == null) {
        emit(state.copyWith(event: FailedSpendingService(message: error)));
        return;
      }

      List<CategoryTotalSpending> spendings = List.from(state.weeklyExpenses);

      final index = spendings.indexWhere((e) => e.category == event.category);
      if (index == -1) {
        spendings.add(
          CategoryTotalSpending(category: event.category, total: event.amount),
        );
      } else {
        spendings[index] = spendings[index].copyWith(event.amount);
      }

      emit(
        state.copyWith(
          event: const ExpenseAddedSuccessfully(),
          weeklyExpenses: spendings,
        ),
      );
    });
  }

  void _storeBudget() {
    on<TriggerStoreBudget>((event, emit) async {
      double budget = event.budget;
      emit(state.copyWith(event: const StoreBudgetBending()));

      await SS.instance.writeBudget(budget: budget);

      emit(state.copyWith(event: StoreBudgetSuccess(), budget: budget));
    });
  }
}
