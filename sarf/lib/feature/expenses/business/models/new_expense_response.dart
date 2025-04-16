part of 'models.dart';

class NewExpenseResponse extends BaseResponse {
  const NewExpenseResponse({required super.code, required super.message});

  factory NewExpenseResponse.fromJSON(dynamic obj) {
    return NewExpenseResponse(
      code: obj['code'] ?? -1,
      message: obj['message'] ?? '',
    );
  }
}
