import 'package:appwise_ecom/utils/colors.dart';
import 'package:flutter/material.dart';

import 'change_password.dart';

void changePasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    sheetAnimationStyle: AnimationStyle(
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeInOutCubic,
    ),
    context: context,
    isScrollControlled: false,
    showDragHandle: true,
    backgroundColor: AppColor.appBgColor,
    builder: (context) {
      return const ChangePassword();
    },
  );
}
