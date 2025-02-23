import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Cards', style: theme.textTheme.titleLarge),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by card name...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    // TODO: Show advanced search options
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              ),
            ),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
            child: Row(
              children: [
                _buildFilterChip(context, 'Monster Cards', false),
                const SizedBox(width: Dimensions.sm),
                _buildFilterChip(context, 'Spell Cards', false),
                const SizedBox(width: Dimensions.sm),
                _buildFilterChip(context, 'Trap Cards', false),
                const SizedBox(width: Dimensions.sm),
                _buildFilterChip(context, 'Extra Deck', false),
              ],
            ),
          ),

          const SizedBox(height: Dimensions.md),

          // Recent Searches
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Searches',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: Dimensions.sm),
                Card(
                  margin: EdgeInsets.zero,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return _buildRecentSearchItem(
                        context,
                        'Dark Magician',
                        'Yesterday',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        // TODO: Implement filter selection
      },
      labelStyle: theme.textTheme.labelLarge?.copyWith(
        color: isSelected
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurface,
      ),
      backgroundColor: theme.colorScheme.surfaceVariant,
      selectedColor: theme.colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
    );
  }

  Widget _buildRecentSearchItem(
    BuildContext context,
    String searchTerm,
    String time,
  ) {
    final theme = Theme.of(context);

    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(
        searchTerm,
        style: theme.textTheme.bodyLarge,
      ),
      subtitle: Text(
        time,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          // TODO: Remove from recent searches
        },
      ),
    );
  }
}
