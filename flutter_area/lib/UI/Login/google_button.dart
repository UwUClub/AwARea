import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0.ratioH()),
      child: TextButton(
        onPressed: onPressed ?? () {},
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
