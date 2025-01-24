import 'package:flutter/material.dart';

import '../utils/text_utility.dart';

AppBar customAppBar({
  String? title,
  Widget? trailing,
}) {
  return AppBar(
    forceMaterialTransparency: true,
    centerTitle: true,
    title: title != null
        ? AppText(
            text: title,
            fontsize: 18,
            fontWeight: FontWeight.w600,
          )
        : null,
    actions: [
      if (trailing != null) trailing,
    ],
  );
}
