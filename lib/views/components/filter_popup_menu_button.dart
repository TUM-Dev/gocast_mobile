import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart'; // Assuming this contains your providers

class FilterPopupMenuButton extends ConsumerWidget {
  final List<String> filterOptions;
  final Function(String) onClick;

  const FilterPopupMenuButton({
    super.key,
    required this.onClick,
    required this.filterOptions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Assuming both selectedSemester and pinnedSelectedSemester are always the same,
    // we can just use one of them for the check mark logic.
    final selectedSemester = ref.read(userViewModelProvider).selectedSemester;
    final selectedSortedOption =
        ref.read(videoViewModelProvider).selectedFilterOption;

    return PopupMenuButton<String>(
      onSelected: (choice) {
        onClick(choice);
      },
      itemBuilder: (BuildContext context) {
        return filterOptions.map((choice) {
          // Check if the item is selected
          bool isSelected =
              selectedSemester == choice || selectedSortedOption == choice;

          return PopupMenuItem<String>(
            value: choice,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(choice),
              trailing: Opacity(
                opacity: isSelected ? 1.0 : 0.0,
                child:
                    Icon(Icons.check, color: Theme.of(context).iconTheme.color),
              ),
            ),
          );
        }).toList();
      },
      icon: Icon(Icons.filter_list, color: Theme.of(context).iconTheme.color),
    );
  }
}
