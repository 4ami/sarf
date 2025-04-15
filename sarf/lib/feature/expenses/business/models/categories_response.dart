part of 'models.dart';

final class CategoriesResponse extends BaseResponse {
  const CategoriesResponse({
    required super.code,
    required super.message,
    this.categories = const [],
  });

  final List<Category> categories;

  factory CategoriesResponse.fromJSON(dynamic obj) {
    List<dynamic> categories = obj['categories'] ?? [];
    return CategoriesResponse(
      code: obj['code'] ?? 500,
      message: obj['message'] ?? '',
      categories: List.generate(
        categories.length,
        (i) => Category.fromJSON(categories[i]),
      ),
    );
  }
}
