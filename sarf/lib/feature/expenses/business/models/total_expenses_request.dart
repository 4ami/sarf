part of 'models.dart';

final class TotalExpensesRequest extends BaseRequest {
  const TotalExpensesRequest({required this.fromDate, required this.toDate});

  final String fromDate, toDate;

  @override
  Map<String, dynamic> toJSON() {
    return {'from_date': fromDate, 'to_date': toDate};
  }
}
