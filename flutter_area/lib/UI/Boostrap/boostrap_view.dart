import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/user_manager.dart';

class BoostrapView extends StatefulWidget {
  const BoostrapView({super.key});

  @override
  State<BoostrapView> createState() => _BoostrapViewState();
}

class _BoostrapViewState extends State<BoostrapView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  UserManager userManager = locator<UserManager>();

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences value) async {
      final String? accessToken = value.getString('accessToken');
      if (accessToken != null) {
        await userManager.getCurrentUser(accessToken);
        userManager.state = AuthStateEnum.authenticated;
      } else {
        userManager.state = AuthStateEnum.unauthenticated;
      }
      _navigateToScreen();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToScreen();
    });
  }

  void _navigateToScreen() {
    switch (userManager.state) {
      case AuthStateEnum.splash:
        Navigator.of(context).pushNamed('/splash');
      case AuthStateEnum.authenticated:
        Navigator.of(context).pushNamed('/home');
      case AuthStateEnum.unauthenticated:
        Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(),
    );
  }
}
