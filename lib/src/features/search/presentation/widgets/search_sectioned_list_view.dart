import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_list_item.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_section_header.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_see_more_button.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_widgets_constants.dart';

/// Sectioned list view for search results, grouped by card name.
/// Each section has a header with card image + title, followed by compact list tiles.
/// Sections with more than [searchSectionInitialLimit] items are paginated with "See More" buttons.
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
    final requestedCount = _visibleCounts[cardName] ?? searchSectionInitialLimit;
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
          child: SearchSeeMoreButton(
            remainingCount: totalCount - visibleCount,
            onTap: () {
              setState(() {
                _visibleCounts[cardName] =
                    (visibleCount + searchSectionExpandIncrement).clamp(0, totalCount);
              });
            },
          ),
        ),
    ];
  }
}
