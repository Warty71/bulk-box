import 'package:flutter/material.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/collection_grid_constants.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/collection_grid_item.dart';

class CollectionPlainGridView extends StatelessWidget {
  const CollectionPlainGridView({
    super.key,
    required this.collectionEntries,
    this.onEntryTap,
    this.onEntryLongPress,
  });

  final List<CollectionEntry> collectionEntries;
  final void Function(CollectionEntry entry)? onEntryTap;
  final void Function(CollectionEntry entry)? onEntryLongPress;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: collectionGridPadding,
      gridDelegate: collectionGridDelegate,
      itemCount: collectionEntries.length,
      itemBuilder: (context, index) {
        final entry = collectionEntries[index];
        return CollectionGridItem(
          entry: entry,
          totalQuantity: entry.quantity,
          onTap: onEntryTap != null ? () => onEntryTap!(entry) : null,
          onLongPress:
              onEntryLongPress != null ? () => onEntryLongPress!(entry) : null,
        );
      },
    );
  }
}
