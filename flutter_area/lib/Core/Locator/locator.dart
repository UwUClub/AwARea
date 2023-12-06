import 'package:get_it/get_it.dart';

import '../Manager/theme_manager.dart';

final GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<ThemeManager>(ThemeManager());
}
