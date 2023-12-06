import 'package:flutter/material.dart';

import '../../Utils/Extensions/color_extensions.dart';

class MkBackground extends StatefulWidget {
  const MkBackground({super.key, required this.child});

  final Widget child;

  @override
  State<MkBackground> createState() => _MkBackgroundState();
}

class _MkBackgroundState extends State<MkBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.lightColor1
          : Theme.of(context).colorScheme.darkColor1,
      child: widget.child,
    );
  }
}
