import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/user_manager.dart';
import '../../Utils/Extensions/double_extensions.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({super.key});

  @override
  State<HomeMobileView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeMobileView> {
  UserManager userManager = locator<UserManager>();

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
        ],
      ),
    ));
  }
}
