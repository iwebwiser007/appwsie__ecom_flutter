import 'package:flutter/material.dart';

import '../../utils/text_utility.dart';

Widget orderStatusButton({
  required String title,
  required bool isActive,
  required VoidCallback onTap,
  bool useInCard = false,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(29),
        border: useInCard ? Border.all() : null,
      ),
      child: AppText(
        text: title,
        fontsize: 14,
        textColor: isActive ? Colors.white : Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
