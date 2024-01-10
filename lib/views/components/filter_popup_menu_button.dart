import 'package:flutter/material.dart';

class FilterPopupMenuButton extends StatefulWidget {
  final Function(String) onFilterSelected;
  final List<String> filterOptions;

  const FilterPopupMenuButton({
    super.key,
    required this.onFilterSelected,
    required this.filterOptions,
  });

  @override
  FilterPopupMenuButtonState createState() => FilterPopupMenuButtonState();
}

class FilterPopupMenuButtonState extends State<FilterPopupMenuButton> {
  String selectedFilterOption = '';

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return PopupMenuButton<String>(
      onSelected: (choice) {
        setState(() {
          selectedFilterOption = choice;
        });
        widget.onFilterSelected(choice);
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
}
