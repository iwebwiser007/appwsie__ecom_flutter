import 'package:flutter/material.dart';

Widget reusableTextButton({
  required String title,
  required VoidCallback onPress,
  TextStyle? style,
}) {
  return TextButton(
    onPressed: onPress,
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
    ),
    child: Text(
      title,
      style: style,
    ),
  );
}
