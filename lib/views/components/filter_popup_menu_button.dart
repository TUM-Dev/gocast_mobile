import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/providers.dart'; // Assuming this contains your providers

class FilterPopupMenuButton extends ConsumerWidget {
  final Function(String) onFilterSelected;
  final List<String> filterOptions;
  final Function(String)? onSemesterSelected;
  final List<String>? semesters;

  const FilterPopupMenuButton({
    super.key,
    required this.onFilterSelected,
    required this.filterOptions,
    this.onSemesterSelected,
    this.semesters,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userViewModel = ref.watch(userViewModelProvider);
    final selectedFilterOption = userViewModel.selectedFilterOption;

    return PopupMenuButton<String>(
      onSelected: (choice) {
        onFilterSelected(choice);
        if (choice == 'Semester') {
          _showSemesterSelectionBottomSheet(context, ref);
        }
      },
      itemBuilder: (BuildContext context) {
        return filterOptions.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: ListTile(
              contentPadding: EdgeInsets.zero, // Removes any inherent padding
              title: Text(choice),
              trailing: selectedFilterOption == choice
                  ? Icon(Icons.check, color: Theme.of(context).iconTheme.color)
                  : null,
            ),
          );
        }).toList();
      },
      icon: Icon(Icons.filter_list, color: Theme.of(context).iconTheme.color),
    );
  }

  void _showSemesterSelectionBottomSheet(BuildContext context, WidgetRef ref) {
    final selectedSemester = ref.read(userViewModelProvider).selectedSemester;

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              ...?semesters?.map((semester) {
                return ListTile(
                  title: Text(semester),
                  trailing: selectedSemester == semester
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    ref
                        .read(userViewModelProvider.notifier)
                        .updateSelectedSemester(semester);
                    if (onSemesterSelected != null) {
                      onSemesterSelected!(semester);
                    }
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}