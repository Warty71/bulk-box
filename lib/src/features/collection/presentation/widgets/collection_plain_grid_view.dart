import 'package:flutter/material.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/collection_grid_constants.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/collection_grid_item.dart';

class CollectionPlainGridView extends StatelessWidget {
  const CollectionPlainGridView({
    super.key,
    required this.collectionEntries,
    required this.getQuantitiesByCardId,
    required this.getCardById,
  });

  final List<CollectionEntry> collectionEntries;
  final Map<int, int> Function() getQuantitiesByCardId;
  final CollectionEntry Function(int) getCardById;

  @override
  Widget build(BuildContext context) {
    final quantitiesByCardId = getQuantitiesByCardId();
    final uniqueCardIds = quantitiesByCardId.keys.toList();

    return GridView.builder(
      padding: collectionGridPadding,
      gridDelegate: collectionGridDelegate,
      itemCount: uniqueCardIds.length,
      itemBuilder: (context, index) {
        final cardId = uniqueCardIds[index];
        final totalQuantity = quantitiesByCardId[cardId]!;
        final entry = getCardById(cardId);

        return CollectionGridItem(
          entry: entry,
          totalQuantity: totalQuantity,
        );
      },
    );
  }
}
