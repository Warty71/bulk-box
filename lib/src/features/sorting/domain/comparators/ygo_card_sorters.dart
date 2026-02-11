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

      case SortOption.frameType:
        final aFrame = (a.card.frameType ?? '').toLowerCase();
        final bFrame = (b.card.frameType ?? '').toLowerCase();
        final frameComparison = aFrame.compareTo(bFrame);
        if (frameComparison != 0) return frameComparison;

        return a.card.name.toLowerCase().compareTo(b.card.name.toLowerCase());

      case SortOption.archetype:
        final aArch = a.card.archetype ?? '';
        final bArch = b.card.archetype ?? '';
        // Nulls/empty last
        if (aArch.isEmpty != bArch.isEmpty) {
          return aArch.isEmpty ? 1 : -1;
        }
        if (aArch.isNotEmpty && bArch.isNotEmpty) {
          final archComparison =
              aArch.toLowerCase().compareTo(bArch.toLowerCase());
          if (archComparison != 0) return archComparison;
        }
        // Secondary: frame type
        final aFrame = (a.card.frameType ?? '').toLowerCase();
        final bFrame = (b.card.frameType ?? '').toLowerCase();
        final frameComparison = aFrame.compareTo(bFrame);
        if (frameComparison != 0) return frameComparison;
        // Tertiary: name
        return a.card.name.toLowerCase().compareTo(b.card.name.toLowerCase());
    }
  });
}
