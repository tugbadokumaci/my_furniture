import 'package:flutter/material.dart';

import '../init/theme/light/color_scheme_light.dart';
import '../init/theme/light/text_theme_light.dart';

class HistoryTextButton extends StatelessWidget {
  final BuildContext context;
  final void Function() onButtonPressed;
  final void Function() onDeletePressed;
  final String query;
  const HistoryTextButton(
      {super.key,
      required this.onButtonPressed,
      required this.onDeletePressed,
      required this.query,
      required this.context});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          IconButton(onPressed: onDeletePressed, icon: Icon(Icons.close, size: 24)),
          TextButton(
              onPressed: onButtonPressed,
              child: Text(query,
                  style: TextThemeLight.instance.TextMedium.copyWith(color: ColorSchemeLight.instance.dark))),
        ],
      ),
    );
  }
}
