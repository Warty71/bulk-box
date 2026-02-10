import 'package:flutter/material.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/collection_plain_grid_view.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/collection_sectioned_grid_view.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

/// Grid view: one tile per (card, set, rarity) — each print/version is a separate entry.
class CollectionGridView extends StatelessWidget {
  const CollectionGridView({
    super.key,
    required this.collectionEntries,
    required this.showDividersBetweenSections,
    required this.sortOption,
    this.onEntryTap,
    this.onEntryLongPress,
  });

  final List<CollectionEntry> collectionEntries;
  final bool showDividersBetweenSections;
  final SortOption sortOption;
  final void Function(CollectionEntry entry)? onEntryTap;
  final void Function(CollectionEntry entry)? onEntryLongPress;

  Map<String, List<CollectionEntry>> _groupBySection(
    List<CollectionEntry> entries,
  ) {
    final groups = <String, List<CollectionEntry>>{};
    for (final entry in entries) {
      final sectionKey = switch (sortOption) {
        SortOption.nameAZ => _getLetterSection(entry.card.name),
        SortOption.cardType => entry.card.type,
        SortOption.frameType => _frameTypeLabel(entry.card.frameType),
        SortOption.archetype => entry.card.archetype?.isNotEmpty == true
            ? entry.card.archetype!
            : 'No Archetype',
      };
      groups.putIfAbsent(sectionKey, () => []).add(entry);
    }
    return groups;
  }

  static const _frameTypeLabels = {
    'normal': 'Normal Monster',
    'effect': 'Effect Monster',
    'ritual': 'Ritual Monster',
    'fusion': 'Fusion Monster',
    'synchro': 'Synchro Monster',
    'xyz': 'XYZ Monster',
    'link': 'Link Monster',
    'normal_pendulum': 'Normal Pendulum',
    'effect_pendulum': 'Effect Pendulum',
    'ritual_pendulum': 'Ritual Pendulum',
    'fusion_pendulum': 'Fusion Pendulum',
    'synchro_pendulum': 'Synchro Pendulum',
    'xyz_pendulum': 'XYZ Pendulum',
    'spell': 'Spell',
    'trap': 'Trap',
    'token': 'Token',
    'skill': 'Skill',
  };

  static String _frameTypeLabel(String? frameType) {
    if (frameType == null) return 'Unknown';
    return _frameTypeLabels[frameType] ?? frameType;
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
              groupBySection: _groupBySection,
              onEntryTap: onEntryTap,
              onEntryLongPress: onEntryLongPress,
            )
          : CollectionPlainGridView(
              key: const ValueKey('plain'),
              collectionEntries: collectionEntries,
              onEntryTap: onEntryTap,
              onEntryLongPress: onEntryLongPress,
            ),
    );
  }
}
