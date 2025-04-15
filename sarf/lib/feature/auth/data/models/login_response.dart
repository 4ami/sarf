part of '../data_lib.dart';

final class LoginResponse extends BaseResponse {
  LoginResponse({
    required super.code,
    required super.message,
    required this.token,
    required this.refToken,
  });

  final String token, refToken;

  factory LoginResponse.fromJSON(dynamic obj) {
    return LoginResponse(
      code: obj['code'] ?? 500,
      message: obj['message'] ?? '',
      token: obj['token'] ?? '',
      refToken: obj['ref_token'] ?? '',
    );
  }
}
