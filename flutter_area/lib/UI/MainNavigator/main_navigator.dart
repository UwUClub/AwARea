import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Core/Manager/user_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../Connections/connections_view.dart';
import '../Home/home_view.dart';
import '../NewTask/new_task_view.dart';
import '../ReusableWidgets/mk_background.dart';
import '../Settings/settings_view.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  ThemeManager themeManager = locator<ThemeManager>();
  UserManager userManager = locator<UserManager>();
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

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
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.lightColor1
          : Theme.of(context).colorScheme.darkColor1,
      body: MkBackground(
        child: Row(
          children: <Widget>[
            SideMenu(
              controller: sideMenu,
              style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.open,
                compactSideMenuWidth: 60,
                hoverColor: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).colorScheme.lightColor3
                    : Theme.of(context).colorScheme.darkColor3,
                selectedHoverColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.lightColor3
                        : Theme.of(context).colorScheme.darkColor3,
                selectedColor: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).colorScheme.lightColor4
                    : Theme.of(context).colorScheme.darkColor4,
                selectedTitleTextStyle: Theme.of(context).brightness ==
                        Brightness.light
                    ? TextStyle(color: Theme.of(context).colorScheme.darkColor2)
                    : TextStyle(
                        color: Theme.of(context).colorScheme.lightColor2),
                unselectedTitleTextStyle: Theme.of(context).brightness ==
                        Brightness.light
                    ? TextStyle(color: Theme.of(context).colorScheme.darkColor2)
                    : TextStyle(
                        color: Theme.of(context).colorScheme.lightColor2),
                selectedIconColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.darkColor2
                        : Theme.of(context).colorScheme.lightColor2,
                unselectedIconColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.darkColor2
                        : Theme.of(context).colorScheme.lightColor2,
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.lightColor2
                        : Theme.of(context).colorScheme.darkColor2,
                toggleColor: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).colorScheme.darkColor2
                    : Theme.of(context).colorScheme.lightColor2,
                itemInnerSpacing: 13.0,
              ),
              showToggle: true,
              title: Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'assets/images/Logo.svg',
                        semanticsLabel: 'Logo',
                        width: 18.0.ratioW(),
                        height: 18.0.ratioH(),
                      )),
                ],
              ),
              items: <SideMenuItem>[
                SideMenuItem(
                  title: AppLocalizations.of(context)!.home,
                  onTap: (int index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.home),
                ),
                SideMenuItem(
                  title: AppLocalizations.of(context)!.profile,
                  onTap: (int index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.person),
                ),
                SideMenuItem(
                  title: AppLocalizations.of(context)!.settings,
                  onTap: (int index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.settings),
                ),
                SideMenuItem(
                  title: AppLocalizations.of(context)!.connection,
                  onTap: (int index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.share),
                ),
                SideMenuItem(
                  title: AppLocalizations.of(context)!.newTask,
                  onTap: (int index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.add_circle),
                ),
                SideMenuItem(
                  builder:
                      (BuildContext context, SideMenuDisplayMode displayMode) {
                    return const Divider(
                      endIndent: 8,
                      indent: 8,
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: <Widget>[
                  const HomeView(),
                  Center(
                    child: Text(AppLocalizations.of(context)!.profile),
                  ),
                  const SettingsView(),
                  const ConnectionsView(),
                  const Center(
                    child: NewTaskView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
