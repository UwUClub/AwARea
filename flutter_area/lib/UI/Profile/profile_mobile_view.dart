import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/user_manager.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';

class ProfileMobileView extends StatefulWidget {
  const ProfileMobileView({super.key});

  @override
  State<ProfileMobileView> createState() => _ProfileMobileViewState();
}

class _ProfileMobileViewState extends State<ProfileMobileView> {
  UserManager userManager = locator<UserManager>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MkBackground(
          child: Padding(
        padding: EdgeInsets.only(
          top: 45.0.ratioH(),
          left: 37.0.ratioW(),
          right: 37.0.ratioW(),
        ),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Text(AppLocalizations.of(context)!.myProfile,
                  style: Theme.of(context).textTheme.titleMedium)
            ]),
            const Divider(
              endIndent: 0,
              indent: 0,
            ),
            Row(children: <Widget>[
              Text(AppLocalizations.of(context)!.logout,
                  style: Theme.of(context).textTheme.labelLarge),
              const Spacer(),
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    await userManager.logout();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  })
            ]),
          ],
        ),
      )),
    );
  }
}
