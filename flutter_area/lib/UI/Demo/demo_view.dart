import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';
import '../ReusableWidgets/mk_button.dart';

class DemoView extends StatefulWidget {
  const DemoView({super.key});

  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  ThemeManager themeManager = locator<ThemeManager>();

  @override
  Widget build(BuildContext context) {
    return MkBackground(
      child: Padding(
        padding: EdgeInsets.only(
            top: 50.0.ratioH(),
            left: 237.0.ratioW(),
            right: 237.0.ratioW(),
            bottom: 36.0.ratioH()),
        child: Center(
            child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.slogan,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0.ratioH()),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              SvgPicture.asset('assets/images/Logo.svg',
                  semanticsLabel: 'Logo',
                  width: 38.0.ratioW(),
                  height: 41.0.ratioH()),
              SizedBox(width: 9.0.ratioW()),
              Text(
                AppLocalizations.of(context)!.subslogan,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              )
            ]),
            SizedBox(height: 40.0.ratioH()),
            Flex(direction: Axis.horizontal, children: [
              MkButton(
                label: AppLocalizations.of(context)!.login,
              ),
              SizedBox(width: 31.0.ratioW()),
              MkButton(
                label: AppLocalizations.of(context)!.signup,
              ),
            ]),
            Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).colorScheme.lightColor2
                    : Theme.of(context).colorScheme.darkColor2,
                child: Text(AppLocalizations.of(context)!.login)),
            ElevatedButton(
                onPressed: () => themeManager.inverseThemeMode(),
                child: Center(
                    child: Text(AppLocalizations.of(context)!.changeMode,
                        style: Theme.of(context).textTheme.labelLarge)))
          ],
        )),
      ),
    );
  }
}
