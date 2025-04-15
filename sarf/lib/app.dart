import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sarf/conf/languages/language_lib.dart';
import 'package:sarf/conf/routing/app_router.dart';
import 'package:sarf/feature/auth/auth_lib.dart';
import 'conf/theme/theme_lib.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeModeCubit()),
        BlocProvider(create: (context) => AppLanguageCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    String fontFamily =
        context.watch<AppLanguageCubit>().state.languageCode.toUpperCase();

    return MaterialApp.router(
      routerConfig: AppRouter.instance.router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.instance.lightMode(fontFamily),
      darkTheme: AppTheme.instance.darkMode(fontFamily),
      themeMode: context.watch<ThemeModeCubit>().state,
      themeAnimationCurve: Curves.elasticInOut,
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        const AppDelegate(),
      ],
      locale: context.watch<AppLanguageCubit>().state,
    );
  }
}
