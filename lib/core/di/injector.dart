import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final injector = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  injector.init();

  // runApp(
  //   EasyLocalization(
  //     supportedLocales: supportLocalizations,
  //     startLocale: const Locale('vi'),
  //     saveLocale: true,
  //     fallbackLocale: const Locale('vi'),
  //     path: translationsPath,
  //     assetLoader: const LocalizationLoader(),
  //     child: const App(),
  //   ),
  // );
}
