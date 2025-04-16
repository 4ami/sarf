part of 'models.dart';

class NewExpenseRequest extends BaseRequest {
  const NewExpenseRequest({required this.amount, required this.category});

  final double amount;
  final int category;

  @override
  Map<String, dynamic> toJSON() {
    return {'amount': amount, 'category': category};
  }
}
