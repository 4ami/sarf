part of '../bloc.dart';

class AuthRegisterState extends AuthLoginState {
  const AuthRegisterState({
    this.fullName = '',
    this.confirmPassword = '',
    super.email,
    super.password,
    super.event,
  });

  final String fullName, confirmPassword;

  @override
  AuthRegisterState copyWith({
    AuthEvent? event,
    String? email,
    String? password,
    String? fullName,
    String? confirmPassword,
  }) {
    return AuthRegisterState(
      fullName: fullName ?? this.fullName,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
      password: password ?? this.password,
      event: event ?? this.event,
    );
  }
}
