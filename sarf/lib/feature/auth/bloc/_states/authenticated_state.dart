part of '../bloc.dart';

final class AuthenticatedState extends AuthState {
  const AuthenticatedState({
    required this.token,
    required this.refToken,
    super.event,
  });

  final String token, refToken;

  @override
  AuthenticatedState copyWith({
    String? token,
    String? refToken,
    AuthEvent? event,
  }) {
    return AuthenticatedState(
      token: token ?? this.token,
      refToken: refToken ?? this.refToken,
      event: event ?? this.event,
    );
  }
}
