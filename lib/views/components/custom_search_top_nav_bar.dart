import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/Filter_Popup_Menu_Button.dart';

class CustomSearchTopNavBar extends ConsumerWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;
  final String title;

  final List<String> filterOptions;
  final Function(String) onClick;

  const CustomSearchTopNavBar({
    super.key,
    required this.searchController,
    required this.title,
    required this.filterOptions,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchActive = ref.watch(isSearchActiveProvider);

    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: isSearchActive
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () =>
                    ref.read(isSearchActiveProvider.notifier).state = false,
              )
            : null,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isSearchActive
              ? _buildSearchField(context)
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    // Adjust left padding here
                    child: Text(
                      title,
                    ),
                  ),
                ),
        ),
        actions: isSearchActive
            ? null
            : [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () =>
                      ref.read(isSearchActiveProvider.notifier).state = true,
                ),
                FilterPopupMenuButton(
                  filterOptions: filterOptions,
                  onClick: onClick,
                ),
              ],
        titleSpacing: 0.0,
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      width: 301,
      height: 36,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search,
              color: Theme.of(context).inputDecorationTheme.hintStyle?.color),
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          hintMaxLines: 1,
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

final isSearchActiveProvider = StateProvider<bool>((ref) => false);
