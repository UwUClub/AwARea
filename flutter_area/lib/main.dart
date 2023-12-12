import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Core/Locator/locator.dart';
import 'Core/Manager/theme_manager.dart';
import 'UI/Demo/demo_view.dart';
import 'UI/Home/home_view.dart';
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

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeManager.themeModeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: "No Man's land",
          theme: themeDataLight(context),
          darkTheme: themeDataDark(context),
          themeMode: currentMode,
          home: const MyHomePage(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    kDeviceHeight = MediaQuery.of(context).size.height;
    kDeviceWidth = MediaQuery.of(context).size.width;
    return const Scaffold(resizeToAvoidBottomInset: false, body: HomeView());
  }
}
