import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/user_manager.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../ReusableWidgets/mk_background.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserManager userManager = locator<UserManager>();

  @override
  Widget build(BuildContext context) {
    return MkBackground(
        child: Padding(
      padding: EdgeInsets.only(
          top: 45.0.ratioH(),
          left: 137.0.ratioW(),
          right: 137.0.ratioW(),
          bottom: 36.0.ratioH()),
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
    ));
  }
}
