import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarf/conf/routing/app_router.dart';
import 'package:sarf/utility/extensions/extensions_lib.dart';
import 'package:sarf/utility/helpers/helpers_lib.dart';
import 'package:sarf/utility/widgets/shared_widgets.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.assets.error404, width: 500),
            Text(
              context.translate(key: 'error_404_page_title'),
              style: context.h1,
            ),
            SizedBox(height: 16),
            Text(
              context.translate(key: 'error_404_page_description'),
              textAlign: TextAlign.center,
              style: context.titleLarge,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 360,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xff4857FC)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                  shape: WidgetStatePropertyAll(StadiumBorder()),
                ),
                onPressed: () => context.go(ApplicationPaths.landing.path),
                child: Text(
                  context.translate(key: 'return_back_home_button_label'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
