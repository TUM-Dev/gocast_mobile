import 'package:flutter/material.dart';

class Tools {
  //private constructor
  Tools._();

  static String extractCourseIds(String title) {
    final pattern = RegExp(r'(?:CIT|IN|MA|CH|MW|PH)\d[\w-]*');
    final matches = pattern.allMatches(title);
    List<String> ids = [];
    for (var match in matches) {
      ids.add(match.group(0)!);
    }
    return ids.join(' , ');
  }

  static String formatDuration(int durationInMinutes) {
    int hours = durationInMinutes ~/ 60;
    int minutes = durationInMinutes % 60;
    int seconds = 0;

    String formattedHours = hours < 10 ? '0$hours' : '$hours';
    String formattedMinutes = minutes < 10 ? '0$minutes' : '$minutes';
    String formattedSeconds = seconds < 10 ? '0$seconds' : '$seconds';

    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  static Color colorPicker(tumID) {
    if (tumID.length < 2) return Colors.grey;
    switch (tumID.substring(0, 2)) {
      case 'IN':
        return Colors.blue;
      case 'MA':
        return Colors.purple;
      case 'CH':
        return Colors.green;
      case 'PH':
        return Colors.orange;
      case 'MW':
        return Colors.red;
      case 'EL':
        return Colors.black87;
      case 'CI':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}
