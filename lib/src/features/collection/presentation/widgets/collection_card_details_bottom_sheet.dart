import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/enums/rarity.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';
import 'package:bulk_box/src/core/widgets/quantity_stepper.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';

String _shortSetCode(String setCode) {
  final i = setCode.indexOf('-');
  return i > 0 ? setCode.substring(0, i) : setCode;
}

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

  /// Pending quantity per box (only when user changed +/- but not yet saved).
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

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _MoveToSheet(
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
        },
      ),
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
                        value: _shortSetCode(entry.setCode),
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
            ..._slots.map((slot) => _SlotTile(
                  boxName: _boxName(slot.boxId),
                  quantity: _displayQuantity(slot),
                  isSaving: _isSaving,
                  onDecrease: () => _changePendingQuantity(slot.boxId, -1),
                  onIncrease: () => _changePendingQuantity(slot.boxId, 1),
                )),
            if (_hasPendingChanges)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
                child: FilledButton(
                  onPressed: _isSaving ? null : _saveQuantities,
                  child: const Text('Save'),
                ),
              ),
            const SizedBox(height: Dimensions.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
              child: OutlinedButton.icon(
                onPressed: _isSaving ? null : _openMoveToSheet,
                icon: const Icon(Icons.drive_file_move_outline),
                label: const Text('Move to...'),
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
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.sm),
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

class _SlotTile extends StatelessWidget {
  final String boxName;
  final int quantity;
  final bool isSaving;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _SlotTile({
    required this.boxName,
    required this.quantity,
    required this.isSaving,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(boxName),
      subtitle: Text('Owned: $quantity'),
      trailing: QuantityStepper(
        value: quantity,
        min: 0,
        max: 999,
        enabled: !isSaving,
        valueWidth: 32,
        onDecrease: onDecrease,
        onIncrease: onIncrease,
      ),
    );
  }
}

/// Sheet to move quantities from current box to others. Fetches all boxes so
/// destinations always include every box (e.g. when viewing Unboxed).
class _MoveToSheet extends StatefulWidget {
  final int? fromBoxId;
  final int fromQuantity;
  final String fromBoxName;
  final Future<void> Function(int? toBoxId, int amount) onMove;
  final VoidCallback onDone;

  const _MoveToSheet({
    required this.fromBoxId,
    required this.fromQuantity,
    required this.fromBoxName,
    required this.onMove,
    required this.onDone,
  });

  @override
  State<_MoveToSheet> createState() => _MoveToSheetState();
}

class _MoveToSheetState extends State<_MoveToSheet> {
  List<Box> _boxes = [];
  bool _loading = true;
  final Map<int?, int> _amountToMove = {}; // toBoxId -> amount

  /// All boxes except the one we're moving from (Unboxed + user boxes).
  List<int?> get _destinationBoxIds {
    final from = widget.fromBoxId;
    final ids = <int?>[null];
    for (final b in _boxes) {
      ids.add(b.id);
    }
    ids.remove(from);
    return ids;
  }

  String _boxName(int? id) {
    if (id == null) return 'Unboxed';
    final list = _boxes.where((x) => x.id == id).toList();
    return list.isEmpty ? 'Box' : list.first.name;
  }

  int get _totalMoving => _amountToMove.values.fold<int>(0, (a, b) => a + b);

  bool get _canMove =>
      widget.fromQuantity > 0 &&
      _totalMoving > 0 &&
      _totalMoving <= widget.fromQuantity;

  @override
  void initState() {
    super.initState();
    _loadBoxes();
  }

  Future<void> _loadBoxes() async {
    final boxRepo = di.getIt<BoxRepository>();
    final boxes = await boxRepo.getBoxes();
    if (!mounted) return;
    setState(() {
      _boxes = boxes;
      _loading = false;
      for (final id in _destinationBoxIds) {
        _amountToMove.putIfAbsent(id, () => 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading) {
      return const Padding(
        padding: EdgeInsets.all(Dimensions.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final destinations = _destinationBoxIds;
    if (destinations.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(Dimensions.lg),
        child: Text(
          'No other boxes. Create a box from the main screen.',
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: Row(
              children: [
                Icon(
                  Icons.drive_file_move_outline,
                  size: 28,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: Dimensions.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Moving to',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        'From ${widget.fromBoxName} (${widget.fromQuantity} available)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...destinations.map((toId) {
            final amount = _amountToMove[toId] ?? 0;
            return ListTile(
              leading: Icon(
                toId == null
                    ? Icons.inbox_outlined
                    : Icons.inventory_2_outlined,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              title: Text(_boxName(toId)),
              trailing: QuantityStepper(
                value: amount,
                min: 0,
                max: widget.fromQuantity - _totalMoving + amount,
                enabled: true,
                onDecrease: () => setState(() {
                  _amountToMove[toId] = (amount - 1).clamp(0, 999);
                }),
                onIncrease: () => setState(() {
                  _amountToMove[toId] = (amount + 1).clamp(
                    0,
                    widget.fromQuantity - _totalMoving + amount,
                  );
                }),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: FilledButton.icon(
              onPressed: _canMove
                  ? () async {
                      for (final e in _amountToMove.entries) {
                        if (e.value > 0) {
                          await widget.onMove(e.key, e.value);
                        }
                      }
                      widget.onDone();
                    }
                  : null,
              icon: const Icon(Icons.drive_file_move),
              label: Text(
                _totalMoving > widget.fromQuantity
                    ? 'Total cannot exceed ${widget.fromQuantity}'
                    : 'Move',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
