library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sarf/feature/auth/auth_lib.dart';
import 'package:sarf/feature/error/view.dart';
import 'package:sarf/feature/expenses/bloc/bloc.dart';
import 'package:sarf/feature/expenses/expenses_lib.dart';
import 'package:sarf/feature/landing/landing.dart';
import 'package:sarf/local/local_storage.dart';

part '_routes/_base_route.dart';
part '_routes/_landing.dart';
part '_routes/_login.dart';
part '_routes/_register.dart';
part '_routes/_expenses_route.dart';

final class RouteObject {
  const RouteObject({required this.path, required this.name});
  final String path, name;
}

final class ApplicationPaths {
  static RouteObject get landing => RouteObject(path: '/', name: 'landing');
  static RouteObject get login => RouteObject(path: '/login', name: 'login');
  static RouteObject get register =>
      RouteObject(path: '/register', name: 'register');

  static RouteObject get expenses =>
      RouteObject(path: '/expenses', name: 'expenses');
}

class AppRouter {
  const AppRouter._();

  static final AppRouter _i = AppRouter._();
  static AppRouter get instance => _i;

  GoRouter get router {
    return GoRouter(
      initialLocation: ApplicationPaths.landing.path,
      errorPageBuilder: (context, state) {
        return MaterialPage(child: ErrorPage());
      },
      redirect: _redirect,
      routes: [
        _LandingRoute().route,
        _LoginRoute().route,
        _RegisterRoute().route,
        _ExpensesRoute().route,
      ],
    );
  }

  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    return await isUserAuthenticated();
  }

  Future<String?> isUserAuthenticated() async {
    String? token = await SS.instance.read('token');
    if (token == null) return null;

    if (JwtDecoder.tryDecode(token) != null) {
      if (!JwtDecoder.isExpired(token)) {
        return ApplicationPaths.expenses.path;
      }
    }

    return null;
  }
}
