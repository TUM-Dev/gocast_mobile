import 'package:flutter/material.dart';

void showAddCustomSpeedDialog(
    BuildContext context, Function(double) onSpeedAdded) {
  double customSpeed = 1.0;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Material(
          type: MaterialType.card,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Add Custom Speed', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
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
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
