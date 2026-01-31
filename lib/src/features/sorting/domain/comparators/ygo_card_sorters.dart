import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

void sortCollectionItems(
  List<CollectionEntry> collectionWithCards,
  SortOption sortOption,
) {
  collectionWithCards.sort((a, b) {
    switch (sortOption) {
      case SortOption.nameAZ:
        return a.card.name.compareTo(b.card.name);

      case SortOption.cardType:
        final typeComparison =
            a.card.type.toLowerCase().compareTo(b.card.type.toLowerCase());
        if (typeComparison != 0) return typeComparison;

        return a.card.name.toLowerCase().compareTo(b.card.name.toLowerCase());
    }
  });
}
