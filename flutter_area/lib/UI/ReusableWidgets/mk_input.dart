import 'package:flutter/material.dart';

import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';

class MkInput extends StatefulWidget {
  const MkInput(
      {super.key,
      required this.label,
      this.placeholder,
      this.onChanged,
      this.displayed = true});

  final String label;
  final String? placeholder;
  final void Function(String)? onChanged;
  final bool displayed;

  @override
  State<MkInput> createState() => _MkInputState();
}

class _MkInputState extends State<MkInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.label,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.left),
        SizedBox(height: 6.0.ratioH()),
        TextField(
          style: Theme.of(context).textTheme.displayMedium,
          onChanged: widget.onChanged,
          obscureText: !widget.displayed,
          decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: Theme.of(context).textTheme.displayMedium,
              filled: true,
              fillColor: Theme.of(context).colorScheme.lightColor3,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.lightColor4,
                      width: 0.5)),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0.ratioW(), vertical: 11.0.ratioH())),
        ),
      ],
    );
  }
}
