part of '../data_lib.dart';

final class RegisterResponse extends BaseResponse {
  const RegisterResponse({
    required super.code,
    required super.message,
    required this.token,
    required this.refToken,
  });

  final String token, refToken;

  factory RegisterResponse.fromJSON(dynamic obj) {
    return RegisterResponse(
      code: obj['code'] ?? 500,
      message: obj['message'] ?? '',
      token: obj['token'] ?? '',
      refToken: obj['ref_token'] ?? '',
    );
  }
}
