import 'package:get_it/get_it.dart';

import '../Manager/action_reaction_manager.dart';
import '../Manager/github_manager.dart';
import '../Manager/google_manager.dart';
import '../Manager/slack_manager.dart';
import '../Manager/theme_manager.dart';
import '../Manager/user_manager.dart';

final GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<ThemeManager>(ThemeManager());
  locator.registerSingleton<UserManager>(UserManager());
  locator.registerSingleton<ActionReactionManager>(ActionReactionManager());
  locator.registerSingleton<SlackManager>(SlackManager());
  locator.registerSingleton<GoogleManager>(GoogleManager());
  locator.registerSingleton<GithubManager>(GithubManager());
}
