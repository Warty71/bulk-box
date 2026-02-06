import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/enums/rarity.dart';
import 'package:bulk_box/src/core/utils/set_code_utils.dart';
import 'package:bulk_box/src/core/widgets/app_bottom_sheets.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/slot_tile.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';

/// Bottom sheet for one card+set+rarity: shows slots (quantities per box)
/// with +/- and a "Move to..." flow to move quantities between boxes.
class CollectionCardDetailsBottomSheet extends StatefulWidget {
  final CollectionEntry entry;
  final CollectionCubit collectionCubit;

  /// The box we're currently viewing (null = Unboxed). Used as "from" in Move sheet.
  final int? currentBoxId;

  const CollectionCardDetailsBottomSheet({
    super.key,
    required this.entry,
    required this.collectionCubit,
    this.currentBoxId,
  });

  @override
  State<CollectionCardDetailsBottomSheet> createState() =>
      _CollectionCardDetailsBottomSheetState();
}

class _CollectionCardDetailsBottomSheetState
    extends State<CollectionCardDetailsBottomSheet> {
  List<CollectionItemEntity> _slots = [];
  Map<int?, String> _boxNames = {}; // null -> 'Unboxed'
  bool _isLoading = true;
  bool _isSaving = false;

  final Map<int?, int> _pendingQuantities = {};

  int get _cardId => widget.entry.card.id;
  String get _setCode => widget.entry.setCode;
  String get _setRarity => widget.entry.setRarity;

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  Future<void> _loadSlots() async {
    final boxRepo = di.getIt<BoxRepository>();
    final boxes = await boxRepo.getBoxes();
    final names = <int?, String>{null: 'Unboxed'};
    for (final b in boxes) {
      names[b.id] = b.name;
    }

    if (!mounted) return;
    final slots = await widget.collectionCubit.getSlotsForCard(
      _cardId,
      _setCode,
      _setRarity,
    );

    if (mounted) {
      setState(() {
        _slots = slots;
        _boxNames = names;
        _isLoading = false;
      });
    }
  }

  String _boxName(int? boxId) => _boxNames[boxId] ?? 'Unboxed';

  int _displayQuantity(CollectionItemEntity slot) =>
      _pendingQuantities[slot.boxId] ?? slot.quantity;

  void _changePendingQuantity(int? boxId, int delta) {
    final match = _slots.where((s) => s.boxId == boxId).toList();
    if (match.isEmpty) return;
    final slot = match.first;
    final current = _pendingQuantities[boxId] ?? slot.quantity;
    final newQty = (current + delta).clamp(0, 999);
    setState(() => _pendingQuantities[boxId] = newQty);
  }

  bool get _hasPendingChanges {
    for (final slot in _slots) {
      final pending = _pendingQuantities[slot.boxId];
      if (pending != null && pending != slot.quantity) return true;
    }
    return false;
  }

  Future<void> _saveQuantities() async {
    if (!_hasPendingChanges || _isSaving) return;
    setState(() => _isSaving = true);
    try {
      for (final slot in _slots) {
        final pending = _pendingQuantities[slot.boxId];
        if (pending == null) continue;
        if (pending != slot.quantity) {
          if (pending <= 0) {
            await widget.collectionCubit
                .deleteSlot(_cardId, _setCode, _setRarity, slot.boxId);
          } else {
            await widget.collectionCubit.updateSlotQuantity(
              _cardId,
              _setCode,
              _setRarity,
              slot.boxId,
              pending,
            );
          }
        }
      }
      _pendingQuantities.clear();
      await _loadSlots();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _openMoveToSheet() {
    if (_slots.isEmpty || _isSaving) return;
    final fromBoxId = widget.currentBoxId;
    final fromSlot = _slots.cast<CollectionItemEntity?>().firstWhere(
          (s) => s?.boxId == fromBoxId,
          orElse: () => null,
        );
    final fromQuantity = fromSlot?.quantity ?? 0;
    if (fromQuantity <= 0) return;

    AppBottomSheets.showMoveTo(
      context,
      fromBoxId: fromBoxId,
      fromQuantity: fromQuantity,
      fromBoxName: _boxName(fromBoxId),
      onMove: (toBoxId, amount) => widget.collectionCubit.moveBetweenSlots(
        _cardId,
        _setCode,
        _setRarity,
        fromBoxId,
        toBoxId,
        amount,
      ),
      onDone: () async {
        Navigator.of(context).pop();
        if (!mounted) return;
        setState(() => _isSaving = true);
        await _loadSlots();
        if (!mounted) return;
        setState(() => _isSaving = false);
        final currentSlot = _slots.cast<CollectionItemEntity?>().firstWhere(
              (s) => s?.boxId == widget.currentBoxId,
              orElse: () => null,
            );
        final qtyInCurrentBox = currentSlot?.quantity ?? 0;
        if (qtyInCurrentBox == 0) {
          Navigator.of(context).pop();
        }
        di.getIt<BoxesCubit>().loadBoxes();
      },
    );
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
                        value: shortSetCode(entry.setCode),
                      ),
                      const SizedBox(width: Dimensions.sm),
                      _infoChip(
                        context,
                        label: 'Rarity',
                        value: Rarity.getShortRarity(entry.setRarity),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(Dimensions.lg),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_slots.isEmpty)
            Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Text(
                'No copies yet.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else ...[
            ..._slots.map(
              (slot) => SlotTile(
                boxName: _boxName(slot.boxId),
                quantity: _displayQuantity(slot),
                isSaving: _isSaving,
                onDecrease: () => _changePendingQuantity(slot.boxId, -1),
                onIncrease: () => _changePendingQuantity(slot.boxId, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
              child: Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: _isSaving ? null : _openMoveToSheet,
                    icon: const Icon(Icons.drive_file_move_outline),
                    label: const Text('Move to...'),
                  ),
                  const SizedBox(width: Dimensions.sm),
                  FilledButton(
                    onPressed: (_hasPendingChanges && !_isSaving)
                        ? _saveQuantities
                        : null,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: Dimensions.md),
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
