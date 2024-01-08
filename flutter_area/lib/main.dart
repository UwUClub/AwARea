// ignore_for_file: unreachable_from_main

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Core/Locator/locator.dart';
import 'Core/Manager/theme_manager.dart';
import 'UI/Callback/callback_github.dart';
import 'UI/Home/home_view.dart';
import 'UI/Login/login_screen.dart';
import 'Utils/constants.dart';
import 'Utils/theme_data.dart';

void main() {
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
            initialRoute: '/login',
            routes: <String, WidgetBuilder>{
              '/login': (BuildContext context) => const LoginScreen(),
              '/home': (BuildContext context) => const HomeView(),
              '/callback': (BuildContext context) => const CallbackGithubView(),
            });
      },
    );
    }
}
