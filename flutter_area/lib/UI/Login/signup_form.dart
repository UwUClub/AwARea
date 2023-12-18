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

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final ThemeManager themeManager = locator<ThemeManager>();
  final UserManager userManager = locator<UserManager>();

  String _fullName = '';
  String _username = '';
  String _email = '';
  String _password = '';
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 108.0.ratioH()),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.lightColor2
          : Theme.of(context).colorScheme.darkColor2,
      child: Center(
        child: SizedBox(
          width: kDeviceWidth > kLargeScreenWidth ? 333.0.ratioW() : null,
          child: Column(children: <Widget>[
            Text(AppLocalizations.of(context)!.signUpTitle,
                style: Theme.of(context).textTheme.headlineLarge),
            Divider(
              color: Theme.of(context).colorScheme.lightColor4,
            ),
            SizedBox(height: 53.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.fullName,
                onChanged: (String text) => setState(() => _fullName = text),
                placeholder: AppLocalizations.of(context)!.fullNamePlaceholder),
            SizedBox(height: 20.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.username,
                onChanged: (String text) => setState(() => _username = text),
                placeholder: AppLocalizations.of(context)!.usernamePlaceholder),
            SizedBox(height: 20.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.email,
                onChanged: (String text) => setState(() => _email = text),
                placeholder: AppLocalizations.of(context)!.emailPlaceholder),
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
                label: '${AppLocalizations.of(context)!.signup}...',
                onPressed: () async {
                  final (bool success, String? error) = await userManager
                      .signUp(_email, _password, _username, _fullName);
                  if (success) {
                    Navigator.of(context).pushNamed('/home');
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
