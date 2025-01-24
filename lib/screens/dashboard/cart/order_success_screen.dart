import 'package:appwise_ecom/constants/image_constants.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/screens/dashboard/dashboard_screen.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/widgets/screen_title_widget.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                ImageConstant.orderSuccesImg,
                height: 213,
                width: 208,
              ),
            ),
            appSpaces.spaceForHeight20,
            const ScreenTitleWidget(title: 'Success!'),
            appSpaces.spaceForHeight5,
            const SizedBox(
              width: 300,
              child: AppText(
                textAlign: TextAlign.center,
                text: 'Your order will be delivered soon.Thank you for choosing our app!',
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Continue Shopping',
              onPressed: () {
                context.pushReplaceAndRemoveUntil(const DashboardScreen());
              },
            ),
            appSpaces.spaceForHeight20,
          ],
        ),
      ),
    );
  }
}
