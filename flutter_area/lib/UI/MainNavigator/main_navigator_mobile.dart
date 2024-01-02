import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Core/Manager/user_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../Connections/connections_mobile_view.dart';
import '../Home/home_mobile_view.dart';
import '../NewTask/new_task_mobile_view.dart';
import '../ReusableWidgets/mk_background.dart';
import '../Settings/settings_mobile_view.dart';

class MainNavigatorMobile extends StatefulWidget {
  const MainNavigatorMobile({super.key});

  @override
  State<MainNavigatorMobile> createState() => _MainNavigatorMobileState();
}

class _MainNavigatorMobileState extends State<MainNavigatorMobile> {
  ThemeManager themeManager = locator<ThemeManager>();
  UserManager userManager = locator<UserManager>();
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');

  @override
  void initState() {
    sideMenu.addListener((int index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MkBackground(
          child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.lightColor1
            : Theme.of(context).colorScheme.darkColor1,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          height: 200.0.ratioH(),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).colorScheme.lightColor2
              : Theme.of(context).colorScheme.darkColor2,
          indicatorColor: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).colorScheme.lightColor4
              : Theme.of(context).colorScheme.darkColor4,
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              label: '',
              selectedIcon: Icon(Icons.home,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.darkColor1
                      : Theme.of(context).colorScheme.lightColor1),
              icon: Icon(Icons.home_outlined,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.lightColor4
                      : Theme.of(context).colorScheme.darkColor4),
            ),
            NavigationDestination(
              label: '',
              selectedIcon: Icon(Icons.account_circle,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.darkColor1
                      : Theme.of(context).colorScheme.lightColor1),
              icon: Icon(Icons.account_circle_outlined,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.lightColor4
                      : Theme.of(context).colorScheme.darkColor4),
            ),
            NavigationDestination(
              label: '',
              selectedIcon: Icon(Icons.settings,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.darkColor1
                      : Theme.of(context).colorScheme.lightColor1),
              icon: Icon(Icons.settings_outlined,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.lightColor4
                      : Theme.of(context).colorScheme.darkColor4),
            ),
            NavigationDestination(
              label: '',
              selectedIcon: Icon(Icons.share,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.darkColor1
                      : Theme.of(context).colorScheme.lightColor1),
              icon: Icon(Icons.share_outlined,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.lightColor4
                      : Theme.of(context).colorScheme.darkColor4),
            ),
            NavigationDestination(
              label: '',
              selectedIcon: Icon(Icons.add_circle,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.darkColor1
                      : Theme.of(context).colorScheme.lightColor1),
              icon: Icon(Icons.add_circle_outline,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.lightColor4
                      : Theme.of(context).colorScheme.darkColor4),
            ),
          ],
        ),
        body: <Widget>[
          const HomeMobileView(),
          const Center(child: Text('Account')),
          const SettingsMobileView(),
          const ConnectionsMobileView(),
          const NewTaskMobileView()
        ][currentPageIndex],
      )),
    );
  }
}
