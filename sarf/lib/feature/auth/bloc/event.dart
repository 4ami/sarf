part of 'bloc.dart';

sealed class AuthEvent {
  const AuthEvent({this.message = ''});
  final String message;
}

class InitalAuthEvent extends AuthEvent {
  const InitalAuthEvent();
}

class PendingAuthService extends AuthEvent {
  const PendingAuthService();
}

class SuccessAuthService extends AuthEvent {
  const SuccessAuthService();
}

class FailedAuthService extends AuthEvent {
  const FailedAuthService({required super.message});
}

class SwitchToLoginEvent extends AuthEvent {
  const SwitchToLoginEvent();
}

class SwitchToRegisterEvent extends AuthEvent {
  const SwitchToRegisterEvent();
}

class Authenticated extends AuthEvent {
  const Authenticated();
}

class EmailChanged extends AuthEvent {
  const EmailChanged({required this.email});
  final String email;
}

class PasswordChanged extends AuthEvent {
  const PasswordChanged({required this.password});
  final String password;
}

class NameChanged extends AuthEvent {
  const NameChanged({required this.fullName});
  final String fullName;
}

class ConfirmPasswordChanged extends AuthEvent {
  const ConfirmPasswordChanged({required this.password});
  final String password;
}

class TriggerLogin extends AuthEvent {
  const TriggerLogin();
}

class TriggerRegister extends AuthEvent {
  const TriggerRegister();
}

class TriggerToken extends AuthEvent {
  const TriggerToken();
}

class Logout extends AuthEvent {
  const Logout();
}
