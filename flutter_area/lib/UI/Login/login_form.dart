import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Core/Manager/user_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../../Utils/constants.dart';
import '../ReusableWidgets/mk_button.dart';
import '../ReusableWidgets/mk_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final ThemeManager themeManager = locator<ThemeManager>();
  final UserManager userManager = locator<UserManager>();

  String _emailOrUsername = '';
  String _password = '';
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: kDeviceWidth > largeScreenWidth ? 108.0.ratioH() : 0),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.lightColor2
          : Theme.of(context).colorScheme.darkColor2,
      child: Center(
        child: SizedBox(
          width: kDeviceWidth > largeScreenWidth ? 333.0.ratioW() : null,
          child: Column(children: <Widget>[
            Text(AppLocalizations.of(context)!.loginTitle,
                style: Theme.of(context).textTheme.headlineLarge),
            Divider(
              color: Theme.of(context).colorScheme.lightColor4,
            ),
            SizedBox(height: 53.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.emailOrUsername,
                onChanged: (String text) =>
                    setState(() => _emailOrUsername = text),
                placeholder:
                    AppLocalizations.of(context)!.emailOrUsernamePlaceholder),
            SizedBox(height: 20.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.password,
                onChanged: (String text) => setState(() => _password = text),
                placeholder: AppLocalizations.of(context)!.passwordPlaceholder),
            SizedBox(height: 28.0.ratioH()),
            if (_errorMessage == null)
              const SizedBox()
            else
              Text(_errorMessage!,
                  style: Theme.of(context).textTheme.headlineLarge?.merge(
                      TextStyle(
                          color: Theme.of(context).colorScheme.redColor))),
            SizedBox(height: 20.0.ratioH()),
            MkButton(
                labelColor: Theme.of(context).colorScheme.darkColor1,
                backgroundColor: Theme.of(context).colorScheme.lightColor3,
                label: '${AppLocalizations.of(context)!.login}...',
                onPressed: () async {
                  final (bool success, String? error) =
                      await userManager.login(_emailOrUsername, _password);
                  if (success) {
                    print('TODO navigate to home screen');
                  } else {
                    setState(() => _errorMessage = error);
                  }
                }),
          ]),
        ),
      ),
    );
  }
}
