import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item_with_card.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_item.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

/// Grid view for displaying unique cards in the collection
class CollectionGridView extends StatelessWidget {
  const CollectionGridView({super.key, required this.itemsWithCards});

  final List<CollectionItemWithCard> itemsWithCards;

  /// Returns total quantity per cardId
  Map<int, int> _getQuantitiesByCardId() {
    final quantities = <int, int>{};
    for (final entry in itemsWithCards) {
      final id = entry.item.cardId;
      quantities[id] = (quantities[id] ?? 0) + entry.item.quantity;
    }
    return quantities;
  }

  /// Returns the first `YgoCard` for a given cardId
  YgoCard _getCardById(int cardId) {
    return itemsWithCards.firstWhere((e) => e.item.cardId == cardId).card;
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

        final card = _getCardById(cardId);

        return CollectionGridItem(
          card: card,
          totalQuantity: totalQuantity,
        );
      },
    );
  }
}
