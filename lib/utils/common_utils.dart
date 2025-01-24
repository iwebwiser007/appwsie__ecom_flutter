import 'package:flutter/material.dart';

import 'colors.dart';

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static snackBar(
    String message,
    BuildContext context, {
    backgroundColor = AppColor.primary,
    int duration = 2,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }
}
