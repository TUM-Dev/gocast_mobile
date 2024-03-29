import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gocast_mobile/views/components/filter_popup_menu_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomSearchTopNavBarWithBackButton extends ConsumerWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;
  final List<String> filterOptions;
  final Function(String) onClick;

  const CustomSearchTopNavBarWithBackButton({
    super.key,
    required this.searchController,
    required this.filterOptions,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: _buildSearchField(context),
        actions: [
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
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)!.search,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).inputDecorationTheme.hintStyle?.color,
          ),
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
