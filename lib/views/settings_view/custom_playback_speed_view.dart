import 'package:flutter/material.dart';

void showAddCustomSpeedDialog(
  BuildContext context,
  Function(double) onSpeedAdded,
) {
  double customSpeed = 1.0;
  String errorMessage = '';

  void validateAndSetSpeed(String value, BuildContext context) {
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      errorMessage = '';

      if (value.isEmpty) {
        errorMessage = '';
      } else {
        double? parsedValue = double.tryParse(value);
        if (parsedValue != null && parsedValue >= 0.25 && parsedValue <= 2.0) {
          List<String> splitValue = value.split('.');
          if ((splitValue[0].length > 1) ||
              (splitValue.length > 1 && splitValue[1].length > 2)) {
            errorMessage = 'Number is too long';
          } else {
            customSpeed = parsedValue;
          }
        } else {
          errorMessage = 'Please enter a number between\n0.25 and 2.0';
        }
      }
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            title: const Text('Add Custom Speed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter speed (e.g., 1.7)',
                    errorText: errorMessage.isNotEmpty ? errorMessage : null,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    setState(() {
                      validateAndSetSpeed(value, context);
                    });
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: errorMessage.isEmpty &&
                        customSpeed >= 0.25 &&
                        customSpeed <= 4.0
                    ? () {
                        Navigator.of(context).pop();
                        onSpeedAdded(customSpeed);
                      }
                    : null,
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}
