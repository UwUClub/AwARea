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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MkBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: kDeviceWidth > kLargeScreenWidth
                    ? 20.0.ratioH()
                    : 150.0.ratioH(),
                left: kDeviceWidth > kLargeScreenWidth
                    ? 237.0.ratioW()
                    : 40.0.ratioW(),
                right: kDeviceWidth > kLargeScreenWidth
                    ? 237.0.ratioW()
                    : 40.0.ratioW(),
                bottom: 18.0.ratioH()),
            child: Column(
              children: <Widget>[
                Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context)!.slogan,
                  style: Theme.of(context).textTheme.titleLarge?.merge(
                      TextStyle(
                          fontSize:
                              (kDeviceWidth > kLargeScreenWidth ? 36 : 22))),
                ),
                SizedBox(height: 8.0.ratioH()),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset('assets/images/Logo.svg',
                          semanticsLabel: 'Logo',
                          width: kDeviceWidth > kLargeScreenWidth
                              ? 32.0.ratioW()
                              : 60.0.ratioW(),
                          height: kDeviceWidth > kLargeScreenWidth
                              ? 32.0.ratioW()
                              : 60.0.ratioW()),
                      SizedBox(width: 10.0.ratioW()),
                      Text(
                        AppLocalizations.of(context)!.subslogan,
                        style: Theme.of(context).textTheme.headlineLarge?.merge(
                            TextStyle(
                                fontSize: kDeviceWidth > kLargeScreenWidth
                                    ? 26
                                    : 18)),
                        textAlign: TextAlign.center,
                      )
                    ]),
                SizedBox(height: 20.0.ratioH()),
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
                if (kDeviceWidth <= kLargeScreenWidth)
                  if (_currentForm == FormType.login)
                    Padding(
                      padding: EdgeInsets.only(top: 40.0.ratioH()),
                      child: GestureDetector(
                          onTap: () =>
                              setState(() => _currentForm = FormType.signUp),
                          child: Text(
                            AppLocalizations.of(context)!.signup,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.merge(const TextStyle(
                                  decoration: TextDecoration.underline,
                                )),
                          )),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.only(top: 40.0.ratioH()),
                      child: GestureDetector(
                          onTap: () =>
                              setState(() => _currentForm = FormType.login),
                          child: Text(AppLocalizations.of(context)!.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.merge(const TextStyle(
                                    decoration: TextDecoration.underline,
                                  )))),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
