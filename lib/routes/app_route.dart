import 'package:appwise_ecom/screens/auth/forget_password.dart';
import 'package:appwise_ecom/screens/auth/signup_screen.dart';
import 'package:appwise_ecom/screens/dashboard/cart/bag_screen.dart';
import 'package:appwise_ecom/screens/dashboard/wishlist/favourites_screen.dart';
import 'package:appwise_ecom/screens/dashboard/profile/profile_screen.dart';
import 'package:appwise_ecom/screens/dashboard/shop/shop_screen.dart';
import 'package:appwise_ecom/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../constants/svg_constants.dart';
import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/dashboard/home_screen.dart';
import '../screens/splash_screen.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    // final args = routeSettings.arguments as dynamic;
    switch (routeSettings.name) {
      // ============onBoarding screens========>
      case '/':
        return MaterialPageRoute(builder: (ctx) => const SplashScreen());
      case '/login_screen':
        return MaterialPageRoute(builder: (ctx) => const LoginScreen());
      case '/sign_up_screen':
        return MaterialPageRoute(builder: (ctx) => const SignupScreen());
      case '/forget_password_screen':
        return MaterialPageRoute(builder: (ctx) => const ForgetPasswordScreen());
      case '/onboarding_screen':
        return MaterialPageRoute(builder: (ctx) => const OnboardingScreen());
      case '/dashboard_screen':
        return MaterialPageRoute(builder: (ctx) => const DashboardScreen());
      default:
        return null;
    }
  }
}

class BottomBarItem {
  final String label;
  final String nav;
  final String? svgIcon;
  final Widget screen;

  BottomBarItem({
    required this.label,
    required this.nav,
    this.svgIcon,
    required this.screen,
  });
}

List<BottomBarItem> bottomBarItems = [
  BottomBarItem(
    label: 'Home',
    nav: '/',
    svgIcon: SvgConstants.bottomBarHome,
    screen: const HomeScreen(),
  ),
  BottomBarItem(
    nav: '/todo',
    label: 'Shop',
    svgIcon: SvgConstants.cartSvg,
    screen: const ShopScreen(),
  ),
  BottomBarItem(
    nav: '/todo',
    label: 'Bag',
    svgIcon: SvgConstants.bagSvg,
    screen: const BagScreen(),
  ),
  BottomBarItem(
    nav: '/todo',
    label: 'Favorites',
    svgIcon: SvgConstants.favoritesSvg,
    screen: const FavouritesScreen(),
  ),
  BottomBarItem(
    nav: '/profile',
    label: 'Profile',
    svgIcon: SvgConstants.bottomBarProfile,
    screen: const AppProfileScreen(),
  ),
];
