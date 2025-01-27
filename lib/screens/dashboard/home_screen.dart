import 'dart:async';

import 'package:appwise_ecom/constants/image_constants.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/home_screen_products_model.dart';
import 'package:appwise_ecom/widgets/dashboard_listing_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constant.dart';
import '../../services/base_url.dart';
import '../../services/request.dart';
import '../../utils/colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/text_utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  List<Product> featuredProducts = [];
  List<Product> bestsellerProducts = [];
  List<Product> newArrivalsPorducts = [];
  List<Product> hotDealsProducts = [];

  void getDashboardData() async {
    try {
      // setLoader(ref, true);

      ApiResponse response = await RequestUtils().getRequest(
        url: ServiceUrl.getHomeProducts,
      );

      if (response.statusCode == 200) {
        final HomeScreenProductsModel responseData = HomeScreenProductsModel.fromJson(
          response.data['data'],
        );

        featuredProducts = responseData.featured!.products!;
        hotDealsProducts = responseData.hotDeals!.products!;
        bestsellerProducts = responseData.bestseller!.products!;
        newArrivalsPorducts = responseData.newArrivals!.products!;

        print(responseData.toJson());

        // Utils.snackBar(response.data['message'], context);
      } else {
        // Utils.snackBar(response.error.toString(), context);
      }

      // setLoader(ref, false);
    } catch (e) {
      // setLoader(ref, false);
      Utils.snackBar(e.toString(), context);

      AppConst.showConsoleLog(e);
    }
  }

  final List<Map<String, String>> onboardingData = [
    {
      "image": ImageConstant.add2,
      "text": "Fashion Sale",
    },
    {
      "image": ImageConstant.add2,
      "text": "New Collection",
    },
    {
      "image": ImageConstant.add2,
      "text": "Street Clothes",
    },
  ];

  Timer? _autoScrollTimer;

  @override
  void initState() {
    getDashboardData();
    _startAutoScroll();
    super.initState();
  }

  void _resetAndStartTimer() {
    _autoScrollTimer?.cancel();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (currentIndex < onboardingData.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: context.screenHeight * 0.6,
              child: PageView.builder(
                allowImplicitScrolling: false,
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  _resetAndStartTimer();
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        data["image"]!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: context.screenHeight * 0.5,
                        child: Container(
                          width: context.screenWidth,
                          padding: const EdgeInsets.all(20.0),
                          child: AppText(
                            text: data["text"]!,
                            textColor: AppColor.white,
                            fontsize: 35,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            fontfamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ProductListWidget(
              headerTitle: 'Featured',
              headerSubtitle: 'Super summer sale',
              productsList: featuredProducts,
            ),
            ProductListWidget(
              headerTitle: 'Best Seller',
              headerSubtitle: 'You’ve never seen it before!',
              isNew: false,
              productsList: bestsellerProducts,
            ),
            ProductListWidget(
              headerTitle: 'New Arrivals',
              headerSubtitle: 'You’ve never seen it before!',
              isNew: true,
              productsList: newArrivalsPorducts,
            ),
            ProductListWidget(
              headerTitle: 'Hot Deals',
              headerSubtitle: 'You’ve never seen it before!',
              isNew: false,
              productsList: hotDealsProducts,
            ),
          ],
        ),
      ),
    );
  }
}
