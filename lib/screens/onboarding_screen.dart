import 'package:appwise_ecom/constants/image_constants.dart';
import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/routes/route_path.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.onboardingBg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              ImageConstant.appLogo,
            ),
            Column(
              children: [
                const AppText(
                  text: 'Welcome to appwise',
                  textColor: AppColor.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                  text: 'Everything you Love, In one place',
                  textColor: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontsize: 30,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Let’s get Started',
                  onPressed: () {
                    context.pushReplacementNamed(RoutePath.loginScreen);
                  },
                  buttonColor: AppColor.white,
                  textColor: AppColor.primary,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
