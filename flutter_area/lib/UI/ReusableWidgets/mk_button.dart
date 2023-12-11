import 'package:flutter/material.dart';

import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';

class MkButton extends StatefulWidget {
  const MkButton({super.key, required this.label, this.onPressed});

  final String label;
  final Function()? onPressed;

  @override
  State<MkButton> createState() => _MkButtonState();
}

class _MkButtonState extends State<MkButton> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 27.0.ratioH(),
        child: TextButton(
          onPressed: widget.onPressed ?? () {},
          style: TextButton.styleFrom(
              surfaceTintColor: Theme.of(context).colorScheme.transparentColor,
              foregroundColor: Theme.of(context).colorScheme.redColor,
              backgroundColor: Theme.of(context).colorScheme.redLightColor),
          child: Center(
              //padding: EdgeInsets.symmetric(vertical: 9.0.ratioH()),
              child: Text(
            widget.label,
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
