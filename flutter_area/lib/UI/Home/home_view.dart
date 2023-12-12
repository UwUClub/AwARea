import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ThemeManager themeManager = locator<ThemeManager>();
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((int index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MkBackground(child: Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.lightColor1
                        : Theme.of(context).colorScheme.darkColor1,
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.open,
              compactSideMenuWidth: 60,
              hoverColor: Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.lightColor3
                                  : Theme.of(context).colorScheme.darkColor3,
              selectedHoverColor: Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.lightColor3
                                  : Theme.of(context).colorScheme.darkColor3,
              selectedColor: Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.lightColor4
                                  : Theme.of(context).colorScheme.darkColor4,
              selectedTitleTextStyle: Theme.of(context).brightness == Brightness.light
                                  ? TextStyle(color: Theme.of(context).colorScheme.darkColor2)
                                  : TextStyle(color: Theme.of(context).colorScheme.lightColor2),
              unselectedTitleTextStyle: Theme.of(context).brightness == Brightness.light
                                  ? TextStyle(color: Theme.of(context).colorScheme.darkColor2)
                                  : TextStyle(color: Theme.of(context).colorScheme.lightColor2),
              selectedIconColor: Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.darkColor2
                                  : Theme.of(context).colorScheme.lightColor2,
              unselectedIconColor: Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.darkColor2
                                  : Theme.of(context).colorScheme.lightColor2,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.lightColor2
                                  : Theme.of(context).colorScheme.darkColor2,
              toggleColor: Theme.of(context).brightness == Brightness.light
                                  ? Theme.of(context).colorScheme.darkColor2
                                  : Theme.of(context).colorScheme.lightColor2,
              itemInnerSpacing: 13.0,
            ),
            showToggle: true,
            title: Row(
              children: [  
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/images/Logo.svg',
                  semanticsLabel: 'Logo',
                  width: 28.0.ratioW(),
                  height: 28.0.ratioH(),
                  )
                ),
              ],  
            ),
            footer: TextButton(
              onPressed: () => themeManager.inverseThemeMode(),
                child: BottomAppBar(
                  child: Text(AppLocalizations.of(context)!.changeMode,
                      style: Theme.of(context).textTheme.labelLarge))),
            items: [
              SideMenuItem(
                title: AppLocalizations.of(context)!.newTask,
                onTap: (int index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.add),
              ),
              SideMenuItem(
                title: AppLocalizations.of(context)!.settings,
                onTap: (int index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                builder: (BuildContext context, SideMenuDisplayMode displayMode) {
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
              children: [
                Center(
                  child: Text(AppLocalizations.of(context)!.newTask),
                ),
                Center(
                  child: Text(AppLocalizations.of(context)!.settings),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
