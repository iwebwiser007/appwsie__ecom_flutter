import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constant.dart';
import '../constants/image_constants.dart';
import '../customs/custom_button.dart';
import '../routes/route_path.dart';
import '../utils/local_storage.dart';
import '../utils/text_utility.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> _sizeAnimation;
  late Animation<double> _moveUpAnimation;
  late Animation<double> _fadeAnimation;

  late AnimationController _controller;
  late AnimationController _moveController;
  late AnimationController _fadeController;

  // Timer(const Duration(seconds: 2), autoSignIn);

  @override
  void initState() {
    super.initState();

    // First animation controller for size expansion
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Expanding animation for the circle
    _sizeAnimation = Tween<double>(begin: 200, end: 420).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Second animation controller for moving up
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Moving-up animation
    _moveUpAnimation = Tween<double>(begin: 0, end: -170).animate(
      CurvedAnimation(parent: _moveController, curve: Curves.easeInOut),
    );

    // Third animation: Fading in the column
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // When the first animation completes, start the move-up animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _moveController.forward();
      }
    });

    _moveController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.forward();
      }
    });

    _controller.forward();
  }

  void autoSignIn() async {
    try {
      final token = await LocalStorage.getToken("access_token");
      AppConst.log('local token========', token);
      if (token == null) {
        AppConst.setAccessToken(null);

        context.pushReplacementNamed(RoutePath.loginScreen);
      } else {
        AppConst.setAccessToken(token);

        context.pushReplacementNamed(RoutePath.dashBoardScreen);
      }
    } catch (e) {
      context.pushReplacementNamed(RoutePath.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([_controller, _moveController]),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _moveUpAnimation.value),
                    child: Container(
                      // duration: const Duration(seconds: 1),
                      // alignment: _moveController.isCompleted ? Alignment.bottomCenter : Alignment.center,
                      // alignment: Alignment.bo,
                      height: _sizeAnimation.value,
                      width: _sizeAnimation.value,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Image.asset(
                        ImageConstant.appLogo,
                        // width: _sizeAnimation.value * 0.6,
                        // height: _sizeAnimation.value * 0.6,
                      ),
                    ),
                  );
                },
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
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
                        autoSignIn();
                      },
                      buttonColor: AppColor.white,
                      textColor: AppColor.primary,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
