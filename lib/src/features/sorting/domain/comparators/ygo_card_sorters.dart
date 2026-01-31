// `collectionWithCards` is List<CollectionItemWithCard>
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item_with_card.dart';
import 'package:ygo_collector/src/features/sorting/domain/entities/sort_options.dart';

void sortCollectionItems(
  List<CollectionItemWithCard> collectionWithCards,
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
