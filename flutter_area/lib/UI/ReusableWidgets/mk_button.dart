import 'package:flutter/material.dart';

import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';

class MkButton extends StatefulWidget {
  const MkButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.labelColor,
      this.backgroundColor});

  final String label;
  final Function()? onPressed;
  final Color? labelColor;
  final Color? backgroundColor;

  @override
  State<MkButton> createState() => _MkButtonState();
}

class _MkButtonState extends State<MkButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.0.ratioH(),
      child: TextButton(
        onPressed: widget.onPressed ?? () {},
        style: TextButton.styleFrom(
            surfaceTintColor: Theme.of(context).colorScheme.transparentColor,
            foregroundColor:
                widget.labelColor ?? Theme.of(context).colorScheme.darkColor1,
            backgroundColor: widget.backgroundColor ??
                Theme.of(context).colorScheme.lightColor2),
        child: Center(
            //padding: EdgeInsets.symmetric(vertical: 9.0.ratioH()),
            child: Text(
          widget.label,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
