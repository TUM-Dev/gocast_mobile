import 'package:flutter/material.dart';

// Define a class for custom colors used throughout the app (Light Theme)
class AppColors {
  static const Color primaryColor = Color(0xFF0D47A1); // Colors.blue[900]
  static const Color primaryTextColor = Colors.black;
  static const Color secondaryTextColor = Colors.black54;
  static const Color appBarBackgroundColor = Colors.white;
  static const Color appBarIconColor = Colors.black;
  static const Color appBarTextColor = Colors.black;
  static const Color sectionTitleColor = Colors.black;
  static const Color indicatorActiveColor = Colors.blue;
  static const Color linkTextColor = Colors.blue;
  static const Color inactiveColor = Colors.grey;
  static const Color tumBlue = Color(0xFF0065BD);
}

// Define a class for custom colors used throughout the app (Dark Theme)
class DarkAppColors {
  static const Color primaryColor = Color(0xFF0D47A1); // Same as light theme
  static const Color primaryTextColor = Colors.white;
  static const Color secondaryTextColor = Colors.white70;
  static const Color appBarBackgroundColor = Colors.black;
  static const Color appBarIconColor = Colors.white;
  static const Color appBarTextColor = Colors.white;
  static const Color sectionTitleColor = Colors.white;
  static const Color indicatorActiveColor = Colors.blue;
  static const Color linkTextColor = Colors.lightBlueAccent;
  static const Color inactiveColor = Color(0xFF757575);
  static const Color tumBlue = Color(0xFF0065BD);
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

// Define a class for custom text styles (Dark Theme)
class DarkAppTextStyles {
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: DarkAppColors.sectionTitleColor,
  );
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: DarkAppColors.primaryTextColor,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: DarkAppColors.secondaryTextColor,
  );
  static const TextStyle link = TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 16,
    color: DarkAppColors.linkTextColor,
  );
}

// Define the app's light theme data
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

// Define the app's dark theme data
final ThemeData darkAppTheme = ThemeData(
  primaryColor: DarkAppColors.primaryColor,
  scaffoldBackgroundColor: DarkAppColors.appBarBackgroundColor,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: DarkAppColors.primaryColor,
    secondary: DarkAppColors.indicatorActiveColor,
  ),
  appBarTheme: const AppBarTheme(
    color: DarkAppColors.appBarBackgroundColor,
    iconTheme: IconThemeData(color: DarkAppColors.appBarIconColor),
    titleTextStyle: TextStyle(
      color: DarkAppColors.appBarTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    titleMedium: DarkAppTextStyles.sectionTitle,
    displayLarge: DarkAppTextStyles.heading,
    bodyLarge: DarkAppTextStyles.body,
    titleSmall: DarkAppTextStyles.link,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: DarkAppColors.primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    hintStyle: TextStyle(
      color: Colors.grey[400],
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF757575), width: 1.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: DarkAppColors.primaryColor, width: 2.0),
    ),
  ),
);
