import 'package:flutter/material.dart';

void showPlaybackSpeedsPicker(
  BuildContext context,
  List<double> selectedPlaybackSpeeds,
  Function(double, bool) updateSelectedSpeeds,
) {
  List<double> defaultSpeeds = List.generate(14, (index) => (index + 1) * 0.25);

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (var speed in defaultSpeeds)
                  _buildSpeedTile(
                    speed: speed,
                    isSelected: selectedPlaybackSpeeds.contains(speed),
                    onTap: updateSelectedSpeeds,
                  ),
                if (selectedPlaybackSpeeds
                    .any((speed) => !defaultSpeeds.contains(speed))) ...[
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Custom Playback Speeds',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (var speed in selectedPlaybackSpeeds
                      .where((speed) => !defaultSpeeds.contains(speed)))
                    _buildSpeedTile(
                      speed: speed,
                      isSelected: true,
                      onTap: updateSelectedSpeeds,
                    ),
                ],
              ],
            ),
          ),
        ],
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
    title: Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 10.0),
      child: Text('${speed}x'),
    ),
    trailing: isSelected ? const Icon(Icons.check) : const SizedBox(),
    onTap: () => onTap(speed, !isSelected),
  );
}
