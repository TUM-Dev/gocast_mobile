/// Constants for the Application
///
/// This file defines various constants used throughout the application.
/// It includes UI-related constants like colors, text styles, padding, and image paths,
/// which help maintain consistency and ease of changes across the app.
///
/// Contains:
/// - Color definitions: Consistent color scheme for the app's UI.
/// - Text Styles: Predefined styles for text used in various parts of the app.
/// - Padding and Sizing constants: Standardized margins and dimensions.
/// - Asset paths: Centralized references to image assets.
///
/// Note: For scalable theme management, consider using ThemeData in conjunction with these constants.
library;

import 'package:flutter/material.dart';

// Padding
class AppPadding {
  static const EdgeInsets sectionPadding = EdgeInsets.all(16.0);
  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
}

// Image Paths
class AppImages {
  static const String course1 = 'assets/images/course1.png';
  static const String course2 = 'assets/images/course2.png';
}

class AppSizes {
  static const double courseListHeight = 200.0;
  static const double indicatorDotSize = 10.0;
  static const double buttonVerticalPadding = 16.0;
}
