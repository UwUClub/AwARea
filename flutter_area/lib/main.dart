import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Core/Locator/locator.dart';
import 'Core/Manager/theme_manager.dart';
import 'UI/Boostrap/boostrap_view.dart';
import 'UI/Callback/callback_github.dart';
import 'UI/Login/login_screen.dart';
import 'UI/MainNavigator/main_navigator.dart';
import 'UI/MainNavigator/main_navigator_mobile.dart';
import 'UI/Splash/splash_view.dart';
import 'Utils/constants.dart';
import 'Utils/theme_data.dart';

void main() async {
  await dotenv.load();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager themeManager = locator<ThemeManager>();
    kDeviceHeight = MediaQuery.of(context).size.height;
    kDeviceWidth = MediaQuery.of(context).size.width;
    kIsPc = kDeviceWidth > kLargeScreenWidth;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeManager.themeModeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
            title: 'Maker',
            theme: themeDataLight(context),
            darkTheme: themeDataDark(context),
            themeMode: currentMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => const BoostrapView(),
              '/login': (BuildContext context) => const LoginScreen(),
              '/home': (BuildContext context) =>
                  kIsPc ? const MainNavigator() : const MainNavigatorMobile(),
              '/splash': (BuildContext context) => const SplashView(),
              '/callback': (BuildContext context) => const CallbackGithubView(),
            });
      },
    );
  }
}
