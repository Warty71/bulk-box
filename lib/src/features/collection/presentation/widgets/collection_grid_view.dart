import 'package:flutter/material.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/collection_plain_grid_view.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/collection_sectioned_grid_view.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

/// Grid view for displaying unique cards in the collection
class CollectionGridView extends StatelessWidget {
  const CollectionGridView({
    super.key,
    required this.collectionEntries,
    required this.showDividersBetweenSections,
    required this.sortOption,
  });

  final List<CollectionEntry> collectionEntries;
  final bool showDividersBetweenSections;
  final SortOption sortOption;

  Map<int, int> _getQuantitiesByCardId() {
    final quantities = <int, int>{};
    for (final entry in collectionEntries) {
      final id = entry.card.id;
      quantities[id] = (quantities[id] ?? 0) + entry.quantity;
    }
    return quantities;
  }

  CollectionEntry _getCardById(int cardId) {
    return collectionEntries.firstWhere((e) => e.card.id == cardId);
  }

  Map<String, List<CollectionEntry>> _groupBySection(
    List<CollectionEntry> entries,
    Map<int, int> quantitiesByCardId,
  ) {
    final groups = <String, List<CollectionEntry>>{};
    final seenCardIds = <int>{};

    for (final entry in entries) {
      if (seenCardIds.contains(entry.card.id)) continue;
      seenCardIds.add(entry.card.id);

      final sectionKey = switch (sortOption) {
        SortOption.nameAZ => _getLetterSection(entry.card.name),
        SortOption.cardType => entry.card.type,
      };

      groups.putIfAbsent(sectionKey, () => []).add(entry);
    }

    return groups;
  }

  String _getLetterSection(String name) {
    if (name.isEmpty) return '#';
    final first = name[0].toUpperCase();
    return (first.compareTo('A') >= 0 && first.compareTo('Z') <= 0)
        ? first
        : '#';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.03),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: showDividersBetweenSections
          ? CollectionSectionedGridView(
              key: const ValueKey('sectioned'),
              collectionEntries: collectionEntries,
              sortOption: sortOption,
              getQuantitiesByCardId: _getQuantitiesByCardId,
              getCardById: _getCardById,
              groupBySection: _groupBySection,
            )
          : CollectionPlainGridView(
              key: const ValueKey('plain'),
              collectionEntries: collectionEntries,
              getQuantitiesByCardId: _getQuantitiesByCardId,
              getCardById: _getCardById,
            ),
    );
  }
}
