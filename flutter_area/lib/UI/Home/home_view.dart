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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ThemeManager themeManager = locator<ThemeManager>();
  UserManager userManager = locator<UserManager>();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset('assets/images/Logo.svg',
              semanticsLabel: 'Logo',
              width: 50.0.ratioW(),
              height: 50.0.ratioH()),
          Text('Bienvenue,\n${userManager.fullName}.',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 24),
              textAlign: TextAlign.center),
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
                      color: Theme.of(context).brightness == Brightness.light
                          ? Theme.of(context).colorScheme.lightColor2
                          : Theme.of(context).colorScheme.darkColor2),
                  padding: EdgeInsets.symmetric(
                      vertical: 50.0.ratioW(), horizontal: 50.0.ratioH()),
                  child: Column(
                    children: <Widget>[
                      TextField(
                          controller: nameController,
                          decoration:
                              const InputDecoration(hintText: 'Enter a name')),
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
                                nameController.text, emailController.text));
                          },
                          child: Text('Send an email',
                              style: Theme.of(context).textTheme.bodyLarge)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
