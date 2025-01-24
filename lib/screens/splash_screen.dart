import 'dart:async';

import 'package:appwise_ecom/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constant.dart';
import '../constants/image_constants.dart';
import '../routes/route_path.dart';
import '../utils/local_storage.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), autoSignIn);
    super.initState();
  }

  void autoSignIn() async {
    try {
      final token = await LocalStorage.getToken("access_token");
      AppConst.log('local token========', token);
      if (token == null) {
        AppConst.setAccessToken(null);

        context.pushReplacementNamed(RoutePath.onboardingScreen);
      } else {
        AppConst.setAccessToken(token);

        context.pushReplacementNamed(RoutePath.dashBoardScreen);
      }
    } catch (e) {
      context.pushReplacementNamed(RoutePath.onboardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstant.appLogo,
          ),
        ],
      ),
    );
  }
}
