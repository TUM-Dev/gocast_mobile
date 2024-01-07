import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart';

class PinButton extends ConsumerWidget {
  final int courseId;
  final bool isInitiallyPinned;
  final VoidCallback onPinStatusChanged;

  const PinButton({
    super.key,
    required this.courseId,
    required this.isInitiallyPinned,
    required this.onPinStatusChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StatefulBuilder(
      builder: (context, setState) {
        return IconButton(
          icon: Icon(
            isInitiallyPinned ? Icons.push_pin : Icons.push_pin_outlined,
            color: Colors.blue[800],
          ),
          onPressed: () async {
            final viewModel = ref.read(userViewModelProvider.notifier);
            if (isInitiallyPinned) {
              await viewModel.unpinCourse(courseId);
            } else {
              await viewModel.pinCourse(courseId);
            }
            setState(() {}); // Trigger rebuild to update icon
            onPinStatusChanged();
          },
        );
      },
    );
  }
}
