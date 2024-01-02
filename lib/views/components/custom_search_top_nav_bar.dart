import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomSearchTopNavBar extends ConsumerWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;
  final String title;

  const CustomSearchTopNavBar({
    super.key,
    required this.searchController,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchActive = ref.watch(isSearchActiveProvider);

    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isSearchActive
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () =>
                    ref.read(isSearchActiveProvider.notifier).state = false,
              )
            : null,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isSearchActive
              ? _buildSearchField(ref)
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    // Adjust left padding here
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
        ),
        actions: isSearchActive
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () =>
                      ref.read(isSearchActiveProvider.notifier).state = true,
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.black),
                  onPressed: () {
                    // Implement filter action
                  },
                ),
              ],
        titleSpacing: 0.0,
      ),
    );
  }

  Widget _buildSearchField(WidgetRef ref) {
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
        onChanged: (value) {},
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

final isSearchActiveProvider = StateProvider<bool>((ref) => false);
