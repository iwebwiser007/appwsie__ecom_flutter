import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/customs/custom_field.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../utils/app_spaces.dart';
import '../../utils/text_utility.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColor.appBgColor,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const AppText(
              text: 'Password Change',
              fontsize: 18,
            ),
            appSpaces.spaceForHeight20,
            customField(
              controller: TextEditingController(),
              hintText: 'Old Password',
            ),
            appSpaces.spaceForHeight15,
            const Align(
              alignment: Alignment.centerRight,
              child: AppText(
                text: "Forgot Password?",
                textColor: AppColor.greyTextColor,
              ),
            ),
            appSpaces.spaceForHeight15,
            customField(controller: TextEditingController(), hintText: 'New Password'),
            appSpaces.spaceForHeight15,
            customField(controller: TextEditingController(), hintText: 'Repeat New Password'),
            CustomButton(
              text: 'SAVE PASSWORD',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
