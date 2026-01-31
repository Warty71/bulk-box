import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_entry.dart';
import 'package:ygo_collector/src/features/sorting/domain/entities/sort_options.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_constants.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_section_header.dart';

class CollectionSectionedGridView extends StatelessWidget {
  const CollectionSectionedGridView({
    super.key,
    required this.collectionEntries,
    required this.sortOption,
    required this.getQuantitiesByCardId,
    required this.getCardById,
    required this.groupBySection,
  });

  final List<CollectionEntry> collectionEntries;
  final SortOption sortOption;
  final Map<int, int> Function() getQuantitiesByCardId;
  final CollectionEntry Function(int) getCardById;
  final Map<String, List<CollectionEntry>> Function(
    List<CollectionEntry>,
    Map<int, int>,
  ) groupBySection;

  @override
  Widget build(BuildContext context) {
    final quantitiesByCardId = getQuantitiesByCardId();
    final groups = groupBySection(collectionEntries, quantitiesByCardId);

    final sectionKeys = groups.keys.toList()
      ..sort((a, b) => a.compareTo(b));

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
                  final totalQuantity = quantitiesByCardId[entry.card.id]!;

                  return CollectionGridItem(
                    entry: entry,
                    totalQuantity: totalQuantity,
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
