import 'package:flutter/material.dart';

void showAddCustomSpeedDialog(
  BuildContext context,
  Function(double) onSpeedAdded,
) {
  double customSpeed = 1.0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
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
              decoration: const InputDecoration(
                hintText: 'Enter speed (e.g., 1.7)',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                customSpeed = double.tryParse(value) ?? 1.0;
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
            child: const Text('Add'),
            onPressed: () {
              Navigator.of(context).pop();
              onSpeedAdded(customSpeed);
            },
          ),
        ],
      );
    },
  );
}
