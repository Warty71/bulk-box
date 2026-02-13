import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_list_item.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_section_header.dart';

/// Max items shown per section before requiring "See More".
const _initialLimit = 5;
/// Number of additional items shown when "See More" is tapped.
const _expandIncrement = 5;

/// Sectioned list view for search results, grouped by card name.
/// Each section has a header with card image + title, followed by compact list tiles.
/// Sections with more than [_initialLimit] items are paginated with "See More" buttons.
class SearchSectionedListView extends StatefulWidget {
  final Map<String, List<SearchResultEntry>> grouped;

  const SearchSectionedListView({super.key, required this.grouped});

  @override
  State<SearchSectionedListView> createState() =>
      _SearchSectionedListViewState();
}

class _SearchSectionedListViewState extends State<SearchSectionedListView> {
  /// Tracks how many items are visible per section (card name -> visible count).
  final Map<String, int> _visibleCounts = {};

  @override
  void didUpdateWidget(SearchSectionedListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Clean up visible counts for card names that no longer exist
    final currentCardNames = widget.grouped.keys.toSet();
    _visibleCounts.removeWhere((name, _) => !currentCardNames.contains(name));
  }

  @override
  Widget build(BuildContext context) {
    final cardNames = widget.grouped.keys.toList();

    return BlocBuilder<QuickAddCubit, QuickAddState>(
      builder: (context, quickAddState) {
        // Add bottom padding when quick add bar is visible to prevent content from being hidden
        final bottomPadding = quickAddState.barVisible ? 80.0 : 0.0;

        return CustomScrollView(
          slivers: [
            for (final name in cardNames) ...[
              // Section header with image + title
              SearchSectionHeader(
                card: widget.grouped[name]!.first.card,
                title: name,
              ),
              // List of set/rarity entries (possibly paginated)
              ..._buildSectionItems(name),
              // Spacing between sections
              const SliverToBoxAdapter(
                child: SizedBox(height: Dimensions.lg),
              ),
            ],
            // Bottom padding to account for QuickAddBar
            if (bottomPadding > 0)
              SliverPadding(
                padding: EdgeInsets.only(bottom: bottomPadding),
              ),
          ],
        );
      },
    );
  }

  List<Widget> _buildSectionItems(String cardName) {
    final entries = widget.grouped[cardName]!;
    final totalCount = entries.length;
    // Clamp visibleCount to actual entries length to prevent RangeError
    final requestedCount = _visibleCounts[cardName] ?? _initialLimit;
    final visibleCount = requestedCount.clamp(0, totalCount);
    final hasMore = visibleCount < totalCount;

    return [
      // Visible items
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final entry = entries[index];
            return SearchListItem(entry: entry);
          },
          childCount: visibleCount,
        ),
      ),
      // "See More" button if there are more items
      if (hasMore)
        SliverToBoxAdapter(
          child: _SeeMoreButton(
            remainingCount: totalCount - visibleCount,
            onTap: () {
              setState(() {
                _visibleCounts[cardName] =
                    (visibleCount + _expandIncrement).clamp(0, totalCount);
              });
            },
          ),
        ),
    ];
  }
}

/// "See More" button that expands a section to show more items.
class _SeeMoreButton extends StatelessWidget {
  final int remainingCount;
  final VoidCallback onTap;

  const _SeeMoreButton({
    required this.remainingCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showCount = remainingCount > _expandIncrement
        ? _expandIncrement
        : remainingCount;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.md,
        vertical: Dimensions.sm,
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.md,
            vertical: Dimensions.sm,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'See $showCount more',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: Dimensions.xs),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
