import 'package:flutter/material.dart';

// Colors
const Color appBarBackgroundColor = Colors.white;
const Color appBarIconColor = Colors.black;
const Color appBarTextColor = Colors.black;
const Color sectionTitleColor = Colors.black;
const Color primaryColor = Colors.blue;
const Color primaryTextColor = Colors.black;
const Color secondaryTextColor = Colors.black54;
const Color indicatorActiveColor = Colors.blue;
const Color linkTextColor = Colors.blue; // Adjust as needed

// Text Styles
const TextStyle sectionTitleTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: sectionTitleColor,
);
// Text Styles
const TextStyle headingTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: primaryTextColor,
);
const TextStyle bodyTextStyle = TextStyle(
  fontSize: 16,
  color: secondaryTextColor,
);
const TextStyle linkTextStyle = TextStyle(
  decoration: TextDecoration.underline,
  fontSize: 16,
);

final ThemeData appTheme = ThemeData(
  // Basic color setup
  primaryColor: primaryColor,
  scaffoldBackgroundColor: appBarBackgroundColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: indicatorActiveColor,
  ),

  // AppBar theme
  appBarTheme: const AppBarTheme(
    color: appBarBackgroundColor,
    iconTheme: IconThemeData(color: appBarIconColor),
    titleTextStyle: TextStyle(
      color: appBarTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Text themes
  textTheme: const TextTheme(
    titleMedium: sectionTitleTextStyle, // Used for section titles
    displayLarge: headingTextStyle, // Used for headings
    bodyLarge: bodyTextStyle, // Used for body text
    titleSmall: linkTextStyle, // Used for links
  ),

  // Button theme
  buttonTheme: ButtonThemeData(
    buttonColor: primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    textTheme: ButtonTextTheme.primary,
  ),

  // Input decoration theme (for text fields)
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    hintStyle: const TextStyle(
        color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500,),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
  ),
);
