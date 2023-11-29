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
const EdgeInsets sectionPadding = EdgeInsets.all(16.0);
const EdgeInsets screenPadding = EdgeInsets.all(16.0);

// Image Paths
const String courseImage1 = 'assets/images/course1.png';
const String courseImage2 = 'assets/images/course2.png';

// Heights
const double courseListHeight = 200.0;

// Other Constants
const double indicatorDotSize = 10.0;
const double buttonVerticalPadding = 16.0;
