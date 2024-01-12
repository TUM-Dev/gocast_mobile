import 'package:flutter/material.dart';

class FilterPopupMenuButton extends StatefulWidget {
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
  FilterPopupMenuButtonState createState() => FilterPopupMenuButtonState();
}

class FilterPopupMenuButtonState extends State<FilterPopupMenuButton> {
  String selectedFilterOption = 'Oldest First';
  String? selectedSemester;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return PopupMenuButton<String>(
      onSelected: (choice) {
        setState(() {
          selectedFilterOption = choice;
        });
        if (choice == 'Semester') {
          _showSemesterSelectionBottomSheet(context);
        } else {
          widget.onFilterSelected(choice);
        }
      },
      itemBuilder: (BuildContext context) {
        return widget.filterOptions.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(choice),
                if (selectedFilterOption == choice)
                  Icon(Icons.check, size: 20, color: themeData.iconTheme.color),
              ],
            ),
          );
        }).toList();
      },
      icon: const Icon(Icons.filter_list, color: Colors.black),
    );
  }

  void _showSemesterSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: widget.semesters?.map((semester) {
                  return ListTile(
                    title: Text(semester),
                    trailing: selectedSemester == semester
                        ? Icon(Icons.check)
                        : null, // Checkmark
                    onTap: () => _selectSemester(semester, context),
                  );
                }).toList() ??
                [],
          ),
        );
      },
    );
  }

  void _selectSemester(String semester, BuildContext context) {
    setState(() {
      selectedSemester = semester; // Update the selected semester
    });
    Navigator.pop(context);
    if (widget.onSemesterSelected != null) {
      widget.onSemesterSelected!(semester);
    }
  }
}