import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_item_card.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

class CollectionListView extends StatelessWidget {
  const CollectionListView({super.key, required this.items});

  final List<CollectionItemEntity> items;

  /// Returns all sets of a given cardId
  List<CardSet> _getCardSets(List<CollectionItemEntity> items, int cardId) {
    final cardItems = items.where((e) => e.cardId == cardId).toList();
    return cardItems
        .map((e) => CardSet(
              setName: e.setCode,
              setCode: e.setCode,
              setRarity: e.setRarity,
            ))
        .toList();
  }

  /// Returns total quantity of a cardId
  int _getTotalQuantity(List<CollectionItemEntity> items, int cardId) {
    final cardItems = items.where((e) => e.cardId == cardId);
    return cardItems.fold<int>(0, (sum, e) => sum + e.quantity.toInt());
  }

  @override
  Widget build(BuildContext context) {
    // Compute unique card IDs
    final uniqueCardIds = items.map((e) => e.cardId).toSet().toList();

    return ListView.builder(
      padding: const EdgeInsets.all(Dimensions.md),
      itemCount: uniqueCardIds.length,
      itemBuilder: (context, index) {
        final cardId = uniqueCardIds[index];
        final cardItems = items.where((e) => e.cardId == cardId).toList();
        final totalQuantity = _getTotalQuantity(items, cardId);
        final cardSets = _getCardSets(items, cardId);
        final name = cardItems.first.cardName;

        return CollectionItemCard(
          card: YgoCard(
            id: cardId,
            name: name,
            type: '',
            description: '',
            race: '',
            imageUrl: '',
            cardSets: cardSets,
          ),
          totalQuantity: totalQuantity,
        );
      },
    );
  }
}
