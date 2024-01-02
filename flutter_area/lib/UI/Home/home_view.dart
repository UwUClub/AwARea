// ignore_for_file: duplicate_import

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
import '../../Utils/constants.dart';
import '../../Utils/mk_print.dart';
import '../Connections/connections_view.dart';
import '../NewTask/new_task_view.dart';
import '../ReusableWidgets/mk_background.dart';
import '../Settings/settings_view.dart';
import 'home_mobile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    if (kIsPc) {
      return MkBackground(
          child: Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.lightColor1
            : Theme.of(context).colorScheme.darkColor1,
        body: Row(
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 100.0.ratioW(), horizontal: 100.0.ratioH()),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(AppLocalizations.of(context)!.home),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Theme.of(context).colorScheme.lightColor2
                                  : Theme.of(context).colorScheme.darkColor2),
                          padding: EdgeInsets.symmetric(
                              vertical: 50.0.ratioW(),
                              horizontal: 50.0.ratioH()),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter a name')),
                              SizedBox(height: 50.0.ratioH()),
                              TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter an email')),
                              SizedBox(height: 50.0.ratioH()),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (nameController.text.isEmpty ||
                                        emailController.text.isEmpty) {
                                      return;
                                    }
                                    mkPrint(await userManager.createDraft(
                                        nameController.text,
                                        emailController.text));
                                  },
                                  child: Text('Send an email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
      ));
    } else {
      return MkBackground(
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
          const SettingsView(),
          const ConnectionsView(),
          const Center(
            child: NewTaskView(),
          ),
        ][currentPageIndex],
      ));
    }
  }
}
