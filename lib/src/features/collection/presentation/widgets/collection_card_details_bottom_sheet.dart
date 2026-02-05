import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';

String _shortSetCode(String setCode) {
  final i = setCode.indexOf('-');
  return i > 0 ? setCode.substring(0, i) : setCode;
}

String _shortRarity(String setRarity) {
  const map = {
    'Common': 'C',
    'Rare': 'R',
    'Super Rare': 'SR',
    'Secret Rare': 'ScR',
    'Ultra Rare': 'UR',
    'Ultimate Rare': 'UtR',
    'Ghost Rare': 'GR',
    'Gold Rare': 'GdR',
    'Premium Gold Rare': 'PGR',
    'Platinum Rare': 'PtR',
    'Starlight Rare': 'StR',
    'Quarter Century Rare': 'QCR',
    "Collector's Rare": 'CR',
  };
  return map[setRarity] ?? setRarity;
}

/// Bottom sheet for a single collection entry (one card + set + rarity).
/// Shows card info, quantity for this version only, and a placeholder for boxes.
class CollectionCardDetailsBottomSheet extends StatefulWidget {
  final CollectionEntry entry;

  const CollectionCardDetailsBottomSheet({
    super.key,
    required this.entry,
  });

  @override
  State<CollectionCardDetailsBottomSheet> createState() =>
      _CollectionCardDetailsBottomSheetState();
}

class _CollectionCardDetailsBottomSheetState
    extends State<CollectionCardDetailsBottomSheet> {
  late int _quantity;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _quantity = widget.entry.quantity;
  }

  void _updateQuantity(int delta) {
    setState(() {
      _quantity = (_quantity + delta).clamp(0, 999);
    });
  }

  Future<void> _openMoveToBoxPicker() async {
    final boxRepo = di.getIt<BoxRepository>();
    final boxes = await boxRepo.getBoxes();

    if (!mounted) return;
    final selected = await showModalBottomSheet<int?>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Text(
                'Move to box',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.inbox_outlined),
              title: const Text('Unboxed'),
              onTap: () => Navigator.of(context).pop<int?>(null),
            ),
            ...boxes.map(
              (box) => ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text(box.name),
                onTap: () => Navigator.of(context).pop<int?>(box.id),
              ),
            ),
          ],
        ),
      ),
    );

    if (selected == null || !mounted) return;

    final cubit = di.getIt<CollectionCubit>();
    await cubit.assignItemToBox(
      widget.entry.card.id,
      widget.entry.setCode,
      widget.entry.setRarity,
      selected,
    );
    if (mounted) {
      setState(() {});
      Navigator.of(context).pop();
    }
  }

  Future<void> _save() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    final cubit = di.getIt<CollectionCubit>();
    final cardId = widget.entry.card.id;
    final setCode = widget.entry.setCode;
    final setRarity = widget.entry.setRarity;

    try {
      if (_quantity == 0) {
        await cubit.deleteCollectionItem(cardId, setCode, setRarity);
      } else {
        await cubit.updateQuantity(cardId, setCode, setRarity, _quantity);
      }
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = widget.entry;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: title and close on same row; set/rarity below
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.md,
              right: Dimensions.md,
              bottom: Dimensions.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: Dimensions.md),
                        child: Text(
                          entry.card.name,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.md),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _infoChip(
                        context,
                        label: 'Set',
                        value: _shortSetCode(entry.setCode),
                      ),
                      const SizedBox(width: Dimensions.sm),
                      _infoChip(
                        context,
                        label: 'Rarity',
                        value: _shortRarity(entry.setRarity),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          // Quantity for this version only
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
            child: Row(
              children: [
                Text(
                  'Quantity',
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed:
                          _quantity > 0 ? () => _updateQuantity(-1) : null,
                    ),
                    SizedBox(
                      width: 48,
                      child: Text(
                        '$_quantity',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed:
                          _quantity < 999 ? () => _updateQuantity(1) : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.xs),

          // Save button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
            child: FilledButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ),

          // Box: show current and "Move to box"
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
            child: ListTile(
              leading: Icon(
                Icons.inbox_outlined,
                size: Dimensions.iconLg,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              title: Text(
                'Box',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              subtitle: Text(entry.boxName ?? 'Unboxed'),
              trailing: TextButton(
                onPressed: _isSaving ? null : _openMoveToBoxPicker,
                child: const Text('Move to box'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(Dimensions.radiusSm),
      ),
      child: Text(
        '$label: $value',
        style: theme.textTheme.labelLarge,
      ),
    );
  }
}
