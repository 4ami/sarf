part of '../data_lib.dart';

final class RegisterRequest extends BaseRequest {
  const RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName, email, password;

  @override
  Map<String, dynamic> toJSON() {
    return {"full_name": fullName, "email": email, "password": password};
  }
}
