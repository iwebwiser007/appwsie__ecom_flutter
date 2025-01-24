import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class TAppTheme {
  TAppTheme._();
  static Gradient primaryGradient = const LinearGradient(
    colors: [Color(0xFF46C5FD), Color(0xFF1A9CD4), Color(0xFF0A91CB)],
    stops: [0, 0.5, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    brightness: Brightness.dark,
    // primaryColor: AppColor.socialWallCard,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.black,
    dividerColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    // cardColor: AppColor.socialWallCard,
    // textTheme: TTextTheme.dartTextTheme,
  );

  static ThemeData lightTheme = ThemeData(
    // useMaterial3: true,
    fontFamily: 'Metropolis',
    // fontFamily: GoogleFonts.poppins().fontFamily,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    brightness: Brightness.light,
    primaryColor: Colors.white,
    // cardColor: AppColor.lightModeCardColor,
    dividerColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.appBgColor,
      iconTheme: IconThemeData(size: 20),
    ),
    scaffoldBackgroundColor: AppColor.appBgColor,
    // textTheme: TTextTheme.lightTextTheme,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primary,
      onPrimary: Colors.white,
      surface: AppColor.placeholderTextGreyColor,
    ),
  );
}
