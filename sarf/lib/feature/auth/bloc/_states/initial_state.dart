part of '../bloc.dart';

class AuthState extends BaseAuthState {
  const AuthState({super.event});

  @override
  AuthState copyWith({AuthEvent? event}) {
    return AuthState(event: event ?? this.event);
  }
}