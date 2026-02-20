import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/search/domain/entities/card_search_filters.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';

/// Monster types (i.e. the `race` field on a monster card).
const _monsterRaces = [
  CardRace.dragon,
  CardRace.warrior,
  CardRace.spellcaster,
  CardRace.beast,
  CardRace.beastWarrior,
  CardRace.wingedBeast,
  CardRace.fiend,
  CardRace.fairy,
  CardRace.insect,
  CardRace.dinosaur,
  CardRace.machine,
  CardRace.aqua,
  CardRace.pyro,
  CardRace.thunder,
  CardRace.rock,
  CardRace.plant,
  CardRace.psychic,
  CardRace.cyberse,
  CardRace.zombie,
  CardRace.wyrm,
];

/// Spell / Trap sub-categories (also mapped to the `race` API param).
const _spellTrapRaces = [
  CardRace.continuous,
  CardRace.counter,
  CardRace.equip,
  CardRace.field,
  CardRace.normalSub,
  CardRace.quickPlay,
  CardRace.ritual,
];

class SearchFiltersSheet extends StatefulWidget {
  const SearchFiltersSheet({super.key, this.initialFilters});

  final CardSearchFilters? initialFilters;

  @override
  State<SearchFiltersSheet> createState() => _SearchFiltersSheetState();
}

class _SearchFiltersSheetState extends State<SearchFiltersSheet> {
  // Multi-select
  List<CardType> _types = [];
  List<MonsterSubtype> _subtypes = [];
  // Single-select
  CardAttribute? _attribute;
  CardRace? _race;
  int? _level;

  @override
  void initState() {
    super.initState();
    final f = widget.initialFilters;
    if (f != null) {
      _types = List.of(f.types);
      _subtypes = List.of(f.subtypes);
      _attribute = f.attribute;
      _race = f.race;
      _level = f.level;
    }
  }

  void _toggleType(CardType t) {
    setState(() {
      _types.contains(t) ? _types.remove(t) : _types.add(t);
    });
  }

  void _toggleSubtype(MonsterSubtype s) {
    setState(() {
      _subtypes.contains(s) ? _subtypes.remove(s) : _subtypes.add(s);
    });
  }

  void _clearAll() {
    setState(() {
      _types = [];
      _subtypes = [];
      _attribute = null;
      _race = null;
      _level = null;
    });
  }

  void _apply() {
    final filters = CardSearchFilters(
      types: List.unmodifiable(_types),
      subtypes: List.unmodifiable(_subtypes),
      attribute: _attribute,
      race: _race,
      level: _level,
    );
    context.read<SearchCubit>().updateFilters(filters);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text('Filter Cards', style: theme.textTheme.titleMedium),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Scrollable filters
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Type — multi-select (OR)
                  _SectionLabel('Card Type'),
                  _MultiChipWrap<CardType>(
                    values: CardType.values,
                    selected: _types,
                    label: (v) => v.displayName,
                    onToggle: _toggleType,
                  ),
                  const SizedBox(height: 16),
                  // Monster Subtype — multi-select (OR)
                  _SectionLabel('Monster Subtype'),
                  _MultiChipWrap<MonsterSubtype>(
                    values: MonsterSubtype.values,
                    selected: _subtypes,
                    label: (v) => v.displayName,
                    onToggle: _toggleSubtype,
                  ),
                  const SizedBox(height: 16),
                  _SectionLabel('Attribute'),
                  _SingleChipWrap<CardAttribute>(
                    values: CardAttribute.values,
                    selected: _attribute,
                    label: (v) => v.displayName,
                    onSelected: (v) => setState(
                      () => _attribute = _attribute == v ? null : v,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SectionLabel('Level / Rank'),
                  _LevelChips(
                    selected: _level,
                    onSelected: (v) =>
                        setState(() => _level = _level == v ? null : v),
                  ),
                  const SizedBox(height: 16),
                  // Monster races
                  _SectionLabel('Monster Type'),
                  _SingleChipWrap<CardRace>(
                    values: _monsterRaces,
                    selected: _race,
                    label: (v) => v.displayName,
                    onSelected: (v) => setState(
                      () => _race = _race == v ? null : v,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Spell / Trap sub-categories
                  _SectionLabel('Spell / Trap Subtype'),
                  _SingleChipWrap<CardRace>(
                    values: _spellTrapRaces,
                    selected: _race,
                    label: (v) => v.displayName,
                    onSelected: (v) => setState(
                      () => _race = _race == v ? null : v,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clearAll,
                    child: const Text('Clear All'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _apply,
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

/// Multi-select chip group using [FilterChip]. Tapping a chip toggles it;
/// multiple chips can be active simultaneously. Selections within this group
/// are combined with OR at the search layer.
class _MultiChipWrap<T> extends StatelessWidget {
  const _MultiChipWrap({
    required this.values,
    required this.selected,
    required this.label,
    required this.onToggle,
  });

  final List<T> values;
  final List<T> selected;
  final String Function(T) label;
  final void Function(T) onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: values.map((v) {
        return FilterChip(
          label: Text(label(v)),
          selected: selected.contains(v),
          onSelected: (_) => onToggle(v),
        );
      }).toList(),
    );
  }
}

/// Single-select chip group using [ChoiceChip]. Tapping the active chip
/// deselects it; tapping another chip replaces the current selection.
class _SingleChipWrap<T> extends StatelessWidget {
  const _SingleChipWrap({
    required this.values,
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  final List<T> values;
  final T? selected;
  final String Function(T) label;
  final void Function(T) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: values.map((v) {
        return ChoiceChip(
          label: Text(label(v)),
          selected: v == selected,
          onSelected: (_) => onSelected(v),
        );
      }).toList(),
    );
  }
}

class _LevelChips extends StatelessWidget {
  const _LevelChips({required this.selected, required this.onSelected});

  final int? selected;
  final void Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: List.generate(12, (i) {
        final level = i + 1;
        return ChoiceChip(
          label: Text('$level'),
          selected: level == selected,
          onSelected: (_) => onSelected(level),
        );
      }),
    );
  }
}
