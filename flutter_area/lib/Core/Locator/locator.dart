import 'package:get_it/get_it.dart';

import '../Manager/theme_manager.dart';
import '../Manager/user_manager.dart';

final GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<ThemeManager>(ThemeManager());
  locator.registerSingleton<UserManager>(UserManager());
}
