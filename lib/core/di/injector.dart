import 'package:base_project/app/app.dart';
import 'package:base_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:local_storage/local_storage.dart';

import 'injector.config.dart';

final injector = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    LocalStorage.init()
  ]);

  injector.init();

  runApp(const App());
}
