import 'dart:async';

import 'package:appwise_ecom/customs/custom_loader.dart';
import 'package:appwise_ecom/extensions/extension.dart';
import 'package:appwise_ecom/models/banners_model.dart';
import 'package:appwise_ecom/models/home_screen_products_model.dart';
import 'package:appwise_ecom/riverpod/user_data_riverpod.dart';
import 'package:appwise_ecom/utils/app_spaces.dart';
import 'package:appwise_ecom/utils/strings_methods.dart';
import 'package:appwise_ecom/widgets/dashboard_listing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constant.dart';
import '../../services/base_url.dart';
import '../../services/request.dart';
import '../../utils/colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/text_utility.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  List<HomeScreenProduct> featuredProducts = [];
  List<HomeScreenProduct> bestsellerProducts = [];
  List<HomeScreenProduct> newArrivalsPorducts = [];
  List<HomeScreenProduct> hotDealsProducts = [];
  List<BannersModel> banners = [];

  void getDashboardData() async {
    try {
      setLoader(ref, true);
      final userId = ref.read(userDataProvider)?.id;

      ApiResponse response = await RequestUtils().getRequest(
        url: "${ServiceUrl.getHomeProducts}?user_id=$userId",
      );

      if (response.statusCode == 200) {
        final HomeScreenProductsModel responseData = HomeScreenProductsModel.fromJson(
          response.data['data'],
        );

        featuredProducts = responseData.featured!.products!;
        hotDealsProducts = responseData.hotDeals!.products!;
        bestsellerProducts = responseData.bestseller!.products!;
        newArrivalsPorducts = responseData.newArrivals!.products!;

        setState(() {});
        getBannersFunc();
      }
      setLoader(ref, false);
    } catch (e) {
      setLoader(ref, false);

      Utils.snackBar(e.toString(), context);

      AppConst.showConsoleLog(e);
    }
  }

  void getBannersFunc() async {
    try {
      ApiResponse response = await RequestUtils().getRequest(
        url: ServiceUrl.getDashboardBanners,
      );

      if (response.statusCode == 200) {
        final List<BannersModel> data = BannersModel.fromList(
          List.from(
            response.data['data'],
          ),
        );

        banners = data;
        setState(() {});

        // Utils.snackBar(response.data['message'], context);
      }

      setLoader(ref, false);
    } catch (e) {
      setLoader(ref, false);
      Utils.snackBar(e.toString(), context);

      AppConst.showConsoleLog(e);
    }
  }

  Timer? _autoScrollTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDashboardData();
    });

    _startAutoScroll();
    super.initState();
  }

  void _resetAndStartTimer() {
    _autoScrollTimer?.cancel();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (currentIndex < banners.length - 1) {
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
                itemCount: banners.length,
                onPageChanged: (index) {
                  _resetAndStartTimer();
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = banners[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: safeString(data.image),
                        // fit: BoxFit.contain,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        progressIndicatorBuilder: (context, url, progress) => const Loader(),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                              colorFilter: const ColorFilter.mode(
                                Color.fromARGB(255, 215, 214, 214),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: context.screenHeight * 0.5,
                        child: Container(
                          width: context.screenWidth,
                          padding: const EdgeInsets.all(20.0),
                          child: AppText(
                            text: safeString(data.title?.capitalizeFirstLetter()),
                            textColor: Colors.white,
                            fontsize: 35,
                            fontWeight: FontWeight.w900,
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
            appSpaces.spaceForHeight30,
            if (featuredProducts.isNotEmpty)
              ProductListWidget(
                headerTitle: 'Featured',
                headerSubtitle: 'Super summer sale',
                productsList: featuredProducts,
              ),
            if (bestsellerProducts.isNotEmpty)
              ProductListWidget(
                headerTitle: 'Best Seller',
                headerSubtitle: 'You’ve never seen it before!',
                isNew: false,
                productsList: bestsellerProducts,
              ),
            if (newArrivalsPorducts.isNotEmpty)
              ProductListWidget(
                headerTitle: 'New Arrivals',
                headerSubtitle: 'You’ve never seen it before!',
                isNew: true,
                productsList: newArrivalsPorducts,
              ),
            if (hotDealsProducts.isNotEmpty)
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
