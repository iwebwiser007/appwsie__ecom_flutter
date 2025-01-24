import 'package:flutter/material.dart';

import '../../utils/text_utility.dart';

Widget profileDetailItem({
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
      contentPadding: const EdgeInsets.all(5),
      title: AppText(
        text: title,
        fontsize: 16,
      ),
      subtitle: AppText(
        text: subtitle,
        fontsize: 12,
        textColor: const Color(0xff9B9B9B),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Color(0xff9B9B9B),
      ),
    ),
  );
}
