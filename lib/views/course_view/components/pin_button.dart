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
    bool isLoggedIn = ref.read(userViewModelProvider).user != null;
    if (!isLoggedIn) {
      return const Icon(
        Icons.push_pin_outlined,
        color: Colors.transparent,
      );
    }
    return StatefulBuilder(
      builder: (context, setState) {
        return IconButton(
          icon: Icon(
            isInitiallyPinned ? Icons.push_pin : Icons.push_pin_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () async {
            final pinnedViewModel =
                ref.read(pinnedCourseViewModelProvider.notifier);
            if (isInitiallyPinned) {
              await pinnedViewModel.unpinCourse(courseId);
            } else {
              await pinnedViewModel.pinCourse(courseId);
            }
            setState(() {}); // Trigger rebuild to update icon
            onPinStatusChanged();
          },
        );
      },
    );
  }
}
