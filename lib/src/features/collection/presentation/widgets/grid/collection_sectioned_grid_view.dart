import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/collection_grid_constants.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/collection_grid_item.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/collection_section_header.dart';

class CollectionSectionedGridView extends StatelessWidget {
  const CollectionSectionedGridView({
    super.key,
    required this.collectionEntries,
    required this.sortOption,
    required this.groupBySection,
  });

  final List<CollectionEntry> collectionEntries;
  final SortOption sortOption;
  final Map<String, List<CollectionEntry>> Function(
    List<CollectionEntry>,
  ) groupBySection;

  @override
  Widget build(BuildContext context) {
    final groups = groupBySection(collectionEntries);
    final sectionKeys = groups.keys.toList()..sort((a, b) => a.compareTo(b));

    return CustomScrollView(
      slivers: [
        for (final sectionKey in sectionKeys) ...[
          CollectionSectionHeader(
            title: sectionKey,
            sortOption: sortOption,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
            sliver: SliverGrid(
              gridDelegate: collectionGridDelegate,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final entry = groups[sectionKey]![index];
                  return CollectionGridItem(
                    entry: entry,
                    totalQuantity: entry.quantity,
                  );
                },
                childCount: groups[sectionKey]!.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: Dimensions.lg),
          ),
        ],
      ],
    );
  }
}
