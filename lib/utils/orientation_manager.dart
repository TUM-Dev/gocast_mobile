import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This class is used to manage orientations for the app
/// It is used in the main.dart file
/// It is also used in the video_player.dart file
class OrientationManager {
  /// Sets orientations for tablets
  static void setOrientationsForTablet() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Sets orientations for phones
  static void setOrientationsForPhone() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Sets all orientations
  static void setAllOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // Determines if the device is a tablet
  static bool _isTablet(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return shortestSide > 600 && pixelRatio < 2;
  }

  // Sets orientations based on device type
  static void setPreferredOrientationsForDevice(BuildContext context) {
    if (_isTablet(context)) {
      setOrientationsForTablet();
    } else {
      setOrientationsForPhone();
    }
  }
}
