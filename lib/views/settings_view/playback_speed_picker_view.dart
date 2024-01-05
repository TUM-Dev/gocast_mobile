import 'package:flutter/material.dart';

void showPlaybackSpeedsPicker(
    BuildContext context,
    List<double> selectedPlaybackSpeeds,
    Function(double, bool) updateSelectedSpeeds) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 14,
              itemBuilder: (context, index) {
                final double speed = (index + 1) * 0.25;
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                    child: Text('${speed}x'),
                  ),
                  trailing: selectedPlaybackSpeeds.contains(speed)
                      ? const Icon(Icons.check)
                      : const SizedBox(),
                  onTap: () {
                    bool isSelected = selectedPlaybackSpeeds.contains(speed);
                    updateSelectedSpeeds(speed, !isSelected);
                  },
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
