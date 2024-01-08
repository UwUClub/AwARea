import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/google_manager.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Core/Manager/user_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../../Utils/mk_print.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ThemeManager themeManager = locator<ThemeManager>();
  UserManager userManager = locator<UserManager>();
  GoogleManager googleManager = locator<GoogleManager>();

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
          SizedBox(height: 50.0.ratioH()),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.redColor),
              onPressed: () async {
                final Uri url = Uri.parse(
                    'https://github.com/UwUClub/AwARea/releases/latest/download/maker.apk');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: Text(AppLocalizations.of(context)!.downloadAPK,
                  style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    ));
  }
}
