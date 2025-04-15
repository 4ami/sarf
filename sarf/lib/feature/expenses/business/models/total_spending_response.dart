part of 'models.dart';

final class TotalSpendingsResponse extends BaseResponse {
  const TotalSpendingsResponse({
    required super.code,
    required super.message,
    required this.totalSpendings,
  });

  final List<CategoryTotalSpending> totalSpendings;

  factory TotalSpendingsResponse.fromJSON(obj) {
    List<dynamic> spendings = obj['expenses'] ?? [];
    return TotalSpendingsResponse(
      code: obj['code'],
      message: obj['message'],
      totalSpendings: List.generate(
        spendings.length,
        (i) => CategoryTotalSpending.fromJSON(spendings[i]),
      ),
    );
  }
}
