import 'package:base_project/app/builder/app_loading_builder.dart';
import 'package:base_project/routes/routes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.routes,
      builder: (context, child) =>
          AppLoadingBuilder(child: child ?? Container()),
    );
  }
}
