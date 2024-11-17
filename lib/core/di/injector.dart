import 'package:base_project/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:local_storage/local_storage.dart';

import 'injector.config.dart';

final injector = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();

  injector.init();

  runApp(const App());
}
