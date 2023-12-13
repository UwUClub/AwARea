import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Utils/Extensions/double_extensions.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({super.key});

  @override
  State<HomeMobileView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeMobileView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0.ratioH()),
      child: Center(
        child: Row(
          children: <Widget>[
            SvgPicture.asset('assets/images/Logo.svg',
                semanticsLabel: 'Logo',
                width: 50.0.ratioW(),
                height: 50.0.ratioH()),
            const Spacer(),
            Text('Bienvenue, MalvinDu87.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
