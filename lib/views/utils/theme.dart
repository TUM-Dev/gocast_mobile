import 'package:flutter/material.dart';

// Define a class for custom colors used throughout the app
class AppColors {
  static const Color primaryColor =
      Color(0xFF0D47A1); // ARGB value of Colors.blue[900]
  static const Color primaryTextColor = Colors.black;
  static const Color secondaryTextColor = Colors.black54;
  static const Color appBarBackgroundColor = Colors.white;
  static const Color appBarIconColor = Colors.black;
  static const Color appBarTextColor = Colors.black;
  static const Color sectionTitleColor = Colors.black;
  static const Color indicatorActiveColor = Colors.blue;
  static const Color linkTextColor = Colors.blue;
  static const Color inactiveColor = Colors.grey;
}

// Define a class for custom text styles
class AppTextStyles {
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.sectionTitleColor,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.secondaryTextColor,
  );

  static const TextStyle link = TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 16,
    color: AppColors.linkTextColor,
  );
}

// Define the app's theme data
final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.appBarBackgroundColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.indicatorActiveColor,
  ),
  appBarTheme: const AppBarTheme(
    color: AppColors.appBarBackgroundColor,
    iconTheme: IconThemeData(color: AppColors.appBarIconColor),
    titleTextStyle: TextStyle(
      color: AppColors.appBarTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: AppTextStyles.sectionTitle,
    displayLarge: AppTextStyles.heading,
    bodyLarge: AppTextStyles.body,
    titleSmall: AppTextStyles.link,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
    ),
  ),
);
