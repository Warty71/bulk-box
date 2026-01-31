import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_entry.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_item.dart';

/// Grid view for displaying unique cards in the collection
class CollectionGridView extends StatelessWidget {
  const CollectionGridView({super.key, required this.collectionEntries});

  final List<CollectionEntry> collectionEntries;

  /// Returns total quantity per cardId
  Map<int, int> _getQuantitiesByCardId() {
    final quantities = <int, int>{};
    for (final entry in collectionEntries) {
      final id = entry.card.id;
      quantities[id] = (quantities[id] ?? 0) + entry.quantity;
    }
    return quantities;
  }

  /// Returns the first `YgoCard` for a given cardId
  CollectionEntry _getCardById(int cardId) {
    return collectionEntries.firstWhere((e) => e.card.id == cardId);
  }

  @override
  Widget build(BuildContext context) {
    final quantitiesByCardId = _getQuantitiesByCardId();
    final uniqueCardIds = quantitiesByCardId.keys.toList();

    return GridView.builder(
      padding: const EdgeInsets.all(Dimensions.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.686,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: uniqueCardIds.length,
      itemBuilder: (context, index) {
        final cardId = uniqueCardIds[index];
        final totalQuantity = quantitiesByCardId[cardId]!;

        final entry = _getCardById(cardId);

        return CollectionGridItem(
          entry: entry,
          totalQuantity: totalQuantity,
        );
      },
    );
  }
}
