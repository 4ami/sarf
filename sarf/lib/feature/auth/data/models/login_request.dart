part of '../data_lib.dart';

final class LoginRequest extends BaseRequest {
  const LoginRequest({required this.email, required this.password});

  final String email, password;

  @override
  Map<String, dynamic> toJSON() {
    return {"email": email, "password": password};
  }
}
