import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Collection', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filters
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sorting
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your collection...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.md,
                  vertical: Dimensions.sm,
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
                _buildFilterChip(context, 'All Cards', true),
                const SizedBox(width: Dimensions.sm),
                _buildFilterChip(context, 'Monster', false),
                const SizedBox(width: Dimensions.sm),
                _buildFilterChip(context, 'Spell', false),
                const SizedBox(width: Dimensions.sm),
                _buildFilterChip(context, 'Trap', false),
              ],
            ),
          ),

          const SizedBox(height: Dimensions.md),

          // Cards Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(Dimensions.md),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: Dimensions.md,
                mainAxisSpacing: Dimensions.md,
              ),
              itemCount: 10, // Example count
              itemBuilder: (context, index) {
                return _buildCardItem(context);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add card
        },
        child: const Icon(Icons.add),
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

  Widget _buildCardItem(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Image
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.radiusMd),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.image_outlined,
                size: Dimensions.iconXl,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          // Card Details
          Padding(
            padding: const EdgeInsets.all(Dimensions.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blue-Eyes White Dragon',
                  style: theme.textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Dimensions.xs),
                Text(
                  'LOB-001',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
