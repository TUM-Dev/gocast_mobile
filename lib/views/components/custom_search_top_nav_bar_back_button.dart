import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSearchTopNavBarWithBackButton extends ConsumerWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;

  const CustomSearchTopNavBarWithBackButton({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios,color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: _buildSearchField(),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              ///TODO: Implement filter action
            },
          ),
        ],
        titleSpacing: 0.0,
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      width: 301,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
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
