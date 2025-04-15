part of '../repository_lib.dart';

final class FetchCategoriesUseCase {
  FetchCategoriesUseCase();
  final SpendingsServices _repo = SpendingsServices();

  Future<CategoriesResponse> fetch({required String token}) async {
    return await _repo.fetchCategories(token: token);
  }
}
