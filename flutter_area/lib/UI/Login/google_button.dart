import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/google_manager.dart';
import '../../Core/Manager/user_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  Future<void> loginWithGoogle(BuildContext context) async {
    final GoogleManager googleManager = locator<GoogleManager>();

    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/gmail.addons.current.action.compose',
      'https://www.googleapis.com/auth/gmail.compose',
    ];

    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: scopes,
    );

    try {
      final GoogleSignInAccount? res = await googleSignIn.signIn();
      final GoogleSignInAuthentication token = await res!.authentication;
      if (token.accessToken == null || res.displayName == null) {
        return;
      }
      final bool success = await googleManager.loginWithGoogle(
          token.accessToken!, res.displayName!, res.email);
      if (success) {
        Navigator.of(context).pushNamed('/home');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0.ratioH()),
      child: TextButton(
        onPressed: () {
          loginWithGoogle(context);
        },
        style: TextButton.styleFrom(
            surfaceTintColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.darkColor1,
            backgroundColor: Theme.of(context).colorScheme.lightColor1),
        child: const Column(children: <Widget>[
          Icon(FontAwesomeIcons.google, size: 20.0, color: Colors.red),
          Text(
            'Se connecter avec Google',
            textAlign: TextAlign.center,
          )
        ]),
      ),
    );
  }
}
