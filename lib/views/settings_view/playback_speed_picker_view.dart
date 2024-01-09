import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showPlaybackSpeedsPicker(
  BuildContext context,
  WidgetRef ref,
  List<double> selectedSpeeds,
  Function(double, bool) updateSelectedSpeeds,
) {
  List<double> defaultSpeeds = List.generate(14, (index) => (index + 1) * 0.25);

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      for (var speed in defaultSpeeds)
                        _buildSpeedTile(
                          speed: speed,
                          isSelected: selectedSpeeds.contains(speed),
                          onTap: (double speed, bool isSelected) {
                            setModalState(() {
                              isSelected
                                  ? selectedSpeeds.add(speed)
                                  : selectedSpeeds.remove(speed);
                              updateSelectedSpeeds(speed, isSelected);
                            });
                          },
                        ),
                      if (selectedSpeeds
                          .any((speed) => !defaultSpeeds.contains(speed))) ...[
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Custom Playback Speeds',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        for (var speed in selectedSpeeds
                            .where((speed) => !defaultSpeeds.contains(speed)))
                          _buildSpeedTile(
                            speed: speed,
                            isSelected: true,
                            onTap: (double speed, bool isSelected) {
                              setModalState(() {
                                isSelected
                                    ? selectedSpeeds.add(speed)
                                    : selectedSpeeds.remove(speed);
                                updateSelectedSpeeds(speed, isSelected);
                              });
                            },
                          ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildSpeedTile({
  required double speed,
  required bool isSelected,
  required Function(double, bool) onTap,
}) {
  return ListTile(
    title: Text('${speed}x'),
    trailing: isSelected ? const Icon(Icons.check) : const SizedBox(),
    onTap: () => onTap(speed, !isSelected),
  );
}
