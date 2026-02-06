import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/widgets/quantity_stepper.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';

/// Bottom sheet to move quantities from one box to others.
/// Fetches all boxes so destinations always include every box (e.g. when viewing Unboxed).
class MoveToBottomSheet extends StatefulWidget {
  final int? fromBoxId;
  final int fromQuantity;
  final String fromBoxName;
  final Future<void> Function(int? toBoxId, int amount) onMove;
  final VoidCallback onDone;

  const MoveToBottomSheet({
    super.key,
    required this.fromBoxId,
    required this.fromQuantity,
    required this.fromBoxName,
    required this.onMove,
    required this.onDone,
  });

  @override
  State<MoveToBottomSheet> createState() => _MoveToBottomSheetState();
}

class _MoveToBottomSheetState extends State<MoveToBottomSheet> {
  List<Box> _boxes = [];
  bool _loading = true;
  final Map<int?, int> _amountToMove = {}; // toBoxId -> amount

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
                        'Moving Card',
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
