part of '../bloc.dart';

class AuthLoginState extends AuthState {
  const AuthLoginState({this.email = '', this.password = '', super.event});

  final String email, password;

  @override
  AuthLoginState copyWith({AuthEvent? event, String? email, String? password}) {
    return AuthLoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      event: event ?? this.event,
    );
  }
}
