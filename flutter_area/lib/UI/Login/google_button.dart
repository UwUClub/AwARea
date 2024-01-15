import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Core/Locator/locator.dart';
import '../../Core/Manager/google_manager.dart';
import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  Future<void> loginWithGoogle(BuildContext context) async {
    final GoogleManager googleManager = locator<GoogleManager>();

    final GoogleSignInAccount? res = await googleManager.openGoogleAuthPopup();
    if (res == null) {
      return;
    }

    final GoogleSignInAuthentication token = await res.authentication;
    if (token.accessToken == null || res.displayName == null) {
      return;
    }
    final bool success = await googleManager.loginWithGoogle(
        token.accessToken!, res.displayName!, res.email);
    if (success) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed('/home');
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
