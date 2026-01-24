import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_item.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

/// Grid view for displaying unique cards in the collection
class CollectionGridView extends StatelessWidget {
  const CollectionGridView({super.key, required this.items});

  final List<CollectionItemEntity> items;

  List<CardSet> assignCardSets(List<CollectionItemEntity> items) {
    final cardSets = <CardSet>[];
    for (final item in items) {
      cardSets.add(CardSet(
          setName: item.setCode,
          setCode: item.setCode,
          setRarity: item.setRarity));
    }
    return cardSets;
  }

  Map<int, int> getQuantitiesByCardId(List<CollectionItemEntity> items) {
    final quantitiesByCardId = <int, int>{};
    for (final item in items) {
      quantitiesByCardId[item.cardId] =
          (quantitiesByCardId[item.cardId] ?? 0) + item.quantity;
    }
    return quantitiesByCardId;
  }

  List<int> getUniqueCardIds(Map<int, int> quantitiesByCardId) {
    return quantitiesByCardId.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    // Group items by cardId to get unique cards with total quantities
    final quantitiesByCardId = getQuantitiesByCardId(items);
    final uniqueCardIds = getUniqueCardIds(quantitiesByCardId);

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

          final cardSets =
              assignCardSets(items.where((e) => e.cardId == cardId).toList());

          final name = items.firstWhere((e) => e.cardId == cardId).cardName;

          return CollectionGridItem(
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
        });
  }
}
