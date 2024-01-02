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
import 'google_button.dart';

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
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0.ratioH()),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.ratioW()),
        color: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.lightColor2
            : Theme.of(context).colorScheme.darkColor2,
      ),
      child: Center(
        child: SizedBox(
          width: kDeviceWidth > kLargeScreenWidth ? 333.0.ratioW() : null,
          child: Column(children: <Widget>[
            // const GoogleButton(),
            Text(AppLocalizations.of(context)!.signUpTitle,
                style: Theme.of(context).textTheme.headlineLarge),
            Divider(
              color: Theme.of(context).colorScheme.lightColor4,
            ),
            SizedBox(height: 15.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.fullName,
                onChanged: (String text) => setState(() => _fullName = text),
                placeholder: AppLocalizations.of(context)!.fullNamePlaceholder),
            SizedBox(height: 10.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.username,
                onChanged: (String text) => setState(() => _username = text),
                placeholder: AppLocalizations.of(context)!.usernamePlaceholder),
            SizedBox(height: 10.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.email,
                onChanged: (String text) => setState(() => _email = text),
                placeholder: AppLocalizations.of(context)!.emailPlaceholder),
            SizedBox(height: 10.0.ratioH()),
            MkInput(
                label: AppLocalizations.of(context)!.password,
                onChanged: (String text) => setState(() => _password = text),
                placeholder: AppLocalizations.of(context)!.passwordPlaceholder,
                displayed: false),
            SizedBox(height: 10.0.ratioH()),
            if (_errorMessage == null)
              const SizedBox()
            else
              Text(_errorMessage!,
                  style: Theme.of(context).textTheme.headlineLarge?.merge(
                      TextStyle(
                          color: Theme.of(context).colorScheme.redColor))),
            SizedBox(height: 10.0.ratioH()),
            if (loading)
              CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.redColor)
            else
              MkButton(
                  labelColor: Theme.of(context).colorScheme.darkColor1,
                  backgroundColor: Theme.of(context).colorScheme.lightColor3,
                  label: '${AppLocalizations.of(context)!.signup}...',
                  onPressed: () async {
                    setState(() => loading = true);
                    final (bool success, String? error) = await userManager
                        .signUp(_email, _password, _username, _fullName);
                    if (success) {
                      Navigator.of(context).pushNamed('/home');
                      setState(() => loading = false);
                    } else {
                      setState(() {
                        _errorMessage = error;
                        loading = false;
                      });
                    }
                  }),
          ]),
        ),
      ),
    );
  }
}
