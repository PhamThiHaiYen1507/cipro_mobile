import 'package:base_project/app/builder/app_loading_builder.dart';
import 'package:base_project/routes/routes.dart';
import 'package:base_project/utils/helpers/app_colors.dart';
import 'package:base_project/utils/helpers/app_text_style.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            titleTextStyle: AppTextStyle.f20B
                .copyWith(color: AppColors.unselectLabelColor)),
      ),
      routerConfig: Routes.routes,
      builder: (context, child) =>
          AppLoadingBuilder(child: child ?? Container()),
    );
  }
}
