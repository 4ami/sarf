library;

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:sarf/feature/auth/data/data_lib.dart';
import 'package:sarf/feature/auth/repository/auth_repo.dart';
import 'package:sarf/local/local_storage.dart';

part 'event.dart';
part '_states/base_state.dart';
part '_states/initial_state.dart';
part '_states/login_state.dart';
part '_states/register_state.dart';
part '_states/authenticated_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    _switchToLogin();
    _switchToRegister();
    _emailChanged();
    _passwordChanged();
    _nameChanged();
    _confirmPasswordChanged();
    _login();
    _register();
    _authenticated();
    _token();
    _logout();
  }

  String _getError(dynamic error) {
    if (error is ClientException) return 'System Backend offline!';
    if (error is Exception) return error.toString();
    if (error is String) return error;
    return "Unexpected Error";
  }

  void _switchToLogin() {
    on<SwitchToLoginEvent>((event, emit) {
      emit(AuthLoginState(event: const SwitchToLoginEvent()));
      log('Switching to Login State', name: 'AuthBloc/Global');
    });
  }

  void _switchToRegister() {
    on<SwitchToRegisterEvent>((event, emit) {
      emit(AuthRegisterState(event: SwitchToRegisterEvent()));
      log('Switching to Register State', name: 'AuthBloc/Global');
    });
  }

  void _emailChanged() {
    on<EmailChanged>((event, emit) {
      if (state is AuthRegisterState) {
        emit((state as AuthRegisterState).copyWith(email: event.email));
        log(
          'Email: ${(state as AuthRegisterState).email}',
          name: 'AuthBloc/Register',
        );
        return;
      }
      emit((state as AuthLoginState).copyWith(email: event.email));
      log('Email: ${(state as AuthLoginState).email}', name: 'AuthBloc/Login');
    });
  }

  void _passwordChanged() {
    on<PasswordChanged>((event, emit) {
      if (state is AuthRegisterState) {
        emit((state as AuthRegisterState).copyWith(password: event.password));
        log(
          'Password: ${(state as AuthRegisterState).password}',
          name: 'AuthBloc/Register',
        );
        return;
      }
      emit((state as AuthLoginState).copyWith(password: event.password));
      log(
        'Password: ${(state as AuthLoginState).password}',
        name: 'AuthBloc/Login',
      );
    });
  }

  void _nameChanged() {
    on<NameChanged>((event, emit) {
      AuthRegisterState st = state as AuthRegisterState;
      emit(st.copyWith(fullName: event.fullName));
    });
  }

  void _confirmPasswordChanged() {
    on<ConfirmPasswordChanged>((event, emit) {
      AuthRegisterState st = state as AuthRegisterState;
      emit(st.copyWith(confirmPassword: event.password));
    });
  }

  void _login() {
    LoginResponse? handleThen(LoginResponse res) {
      if (res.code != 200) {
        throw res.message;
      }

      return res;
    }

    on<TriggerLogin>((event, emit) async {
      AuthLoginState loginState = state as AuthLoginState;

      emit(loginState.copyWith(event: const PendingAuthService()));

      String error = "";

      AuthLoginUseCase useCase = AuthLoginUseCase();

      LoginRequest request = LoginRequest(
        email: loginState.email,
        password: loginState.password,
      );

      print('send request');
      LoginResponse? response = await useCase
          .execute(req: request)
          .then(handleThen)
          .catchError((er) {
            error = _getError(er);
            return null;
          });

      if (error.isNotEmpty || response == null) {
        emit(loginState.copyWith(event: FailedAuthService(message: error)));
        return;
      }

      await SS.instance.write(key: 'token', value: response.token);
      await SS.instance.write(key: 'ref_token', value: response.refToken);

      emit(loginState.copyWith(event: const SuccessAuthService()));
    });
  }

  void _register() {
    RegisterResponse? handleThen(RegisterResponse res) {
      if (res.code != 201) throw res.message;
      return res;
    }

    on<TriggerRegister>((event, emit) async {
      AuthRegisterState regState = state as AuthRegisterState;

      emit(regState.copyWith(event: const PendingAuthService()));

      String error = "";

      RegisterUseCase useCase = RegisterUseCase();

      RegisterRequest request = RegisterRequest(
        fullName: regState.fullName,
        email: regState.email,
        password: regState.password,
      );

      RegisterResponse? response = await useCase
          .execute(req: request)
          .then(handleThen)
          .catchError((er) {
            error = _getError(er);
            return null;
          });

      if (error.isNotEmpty || response == null) {
        emit(regState.copyWith(event: FailedAuthService(message: error)));
        return;
      }

      await SS.instance.write(key: 'token', value: response.token);
      await SS.instance.write(key: 'ref_token', value: response.refToken);

      emit(regState.copyWith(event: const SuccessAuthService()));
    });
  }

  void _authenticated() {
    on<Authenticated>((event, emit) async {
      String? token = await SS.instance.read('token');
      String? refToken = await SS.instance.read('refToken');
      if (token == null || refToken == null) return;
      emit(AuthenticatedState(token: token, refToken: refToken));
    });
  }

  void _token() {
    String? handleThen(String res) {
      if (res.isEmpty) throw 'Re-Login';
      return res;
    }

    on<TriggerToken>((event, emit) async {
      emit(state.copyWith(event: const PendingAuthService()));

      TokenUseCase useCase = TokenUseCase();

      String? refToken = await SS.instance.read('ref_token');
      String error = "";

      if (refToken == null) {
        emit(
          state.copyWith(event: const FailedAuthService(message: 'Re-Login')),
        );
        return;
      }

      String? response = await useCase
          .execute(refToken: refToken)
          .then(handleThen)
          .catchError((er) {
            error = _getError(er);
            return null;
          });

      if (error.isNotEmpty || response == null) {
        emit(state.copyWith(event: FailedAuthService(message: error)));
        return;
      }

      await SS.instance.write(key: 'toke', value: response);

      emit(state.copyWith(event: const SuccessAuthService()));
    });
  }

  void _logout() {
    on<Logout>((event, emit) async {
      emit(state.copyWith(event: const PendingAuthService()));
      await SS.instance.delete(key: 'token');
      await SS.instance.delete(key: 'ref_token');

      emit(AuthState(event: const SuccessAuthService()));
    });
  }
}
