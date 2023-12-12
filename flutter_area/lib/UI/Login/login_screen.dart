import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/theme_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../../Utils/constants.dart';
import '../ReusableWidgets/mk_background.dart';
import '../ReusableWidgets/mk_button.dart';
import 'login_form.dart';
import 'signup_form.dart';

enum FormType { login, signUp }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ThemeManager themeManager = locator<ThemeManager>();

  FormType _currentForm = FormType.login;

  @override
  Widget build(BuildContext context) {
    return MkBackground(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: 50.0.ratioH(),
              left: kDeviceWidth > kLargeScreenWidth
                  ? 237.0.ratioW()
                  : 33.0.ratioW(),
              right: kDeviceWidth > kLargeScreenWidth
                  ? 237.0.ratioW()
                  : 33.0.ratioW(),
              bottom: 36.0.ratioH()),
          child: Column(
            children: <Widget>[
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.slogan,
                style: Theme.of(context).textTheme.titleLarge?.merge(TextStyle(
                    fontSize: (kDeviceWidth > kLargeScreenWidth ? 36 : 22))),
              ),
              SizedBox(height: 8.0.ratioH()),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/images/Logo.svg',
                        semanticsLabel: 'Logo',
                        width: 38.0.ratioW(),
                        height: 41.0.ratioH()),
                    SizedBox(width: 9.0.ratioW()),
                    Text(
                      AppLocalizations.of(context)!.subslogan,
                      style: Theme.of(context).textTheme.headlineLarge?.merge(
                          TextStyle(
                              fontSize:
                                  kDeviceWidth > kLargeScreenWidth ? 26 : 13)),
                      textAlign: TextAlign.center,
                    )
                  ]),
              SizedBox(height: 40.0.ratioH()),
              if (kDeviceWidth > kLargeScreenWidth)
                Flex(direction: Axis.horizontal, children: <Widget>[
                  Flexible(
                      child: MkButton(
                    labelColor: _currentForm == FormType.login
                        ? Theme.of(context).colorScheme.redColor
                        : null,
                    backgroundColor: _currentForm == FormType.login
                        ? Theme.of(context).colorScheme.redLightColor
                        : null,
                    label: AppLocalizations.of(context)!.login,
                    onPressed: () =>
                        setState(() => _currentForm = FormType.login),
                  )),
                  SizedBox(width: 31.0.ratioW()),
                  Flexible(
                    child: MkButton(
                      labelColor: _currentForm == FormType.signUp
                          ? Theme.of(context).colorScheme.redColor
                          : null,
                      backgroundColor: _currentForm == FormType.signUp
                          ? Theme.of(context).colorScheme.redLightColor
                          : null,
                      label: AppLocalizations.of(context)!.signup,
                      onPressed: () =>
                          setState(() => _currentForm = FormType.signUp),
                    ),
                  ),
                ])
              else
                const SizedBox(),
              SizedBox(height: 14.0.ratioH()),
              if (_currentForm == FormType.login)
                const LoginForm()
              else
                const SignupForm(),
              ElevatedButton(
                  onPressed: () => themeManager.inverseThemeMode(),
                  child: Center(
                      child: Text(AppLocalizations.of(context)!.changeMode,
                          style: Theme.of(context).textTheme.labelLarge))),
            ],
          ),
        ),
      ),
    );
  }
}
