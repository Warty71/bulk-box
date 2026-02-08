import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';

/// Bottom sheet to pick a single destination for moving multiple selected cards.
/// Shows Unboxed + all boxes except the current [fromBoxId].
class BulkMoveDestinationBottomSheet extends StatefulWidget {
  final int? fromBoxId;
  final String fromBoxName;
  final int selectedCount;
  final void Function(int? toBoxId) onMoveTo;

  const BulkMoveDestinationBottomSheet({
    super.key,
    required this.fromBoxId,
    required this.fromBoxName,
    required this.selectedCount,
    required this.onMoveTo,
  });

  @override
  State<BulkMoveDestinationBottomSheet> createState() =>
      _BulkMoveDestinationBottomSheetState();
}

class _BulkMoveDestinationBottomSheetState
    extends State<BulkMoveDestinationBottomSheet> {
  List<Box> _boxes = [];
  bool _loading = true;

  List<int?> get _destinationIds {
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
    });
  }

  void _pickDestination(int? toBoxId) {
    widget.onMoveTo(toBoxId);
    Navigator.of(context).pop();
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

    final destinations = _destinationIds;
    if (destinations.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(Dimensions.lg),
        child: Text(
          'No other boxes. Create a box from the Boxes screen.',
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
                        'Move ${widget.selectedCount} card${widget.selectedCount == 1 ? '' : 's'}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        'From ${widget.fromBoxName}',
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
            return ListTile(
              leading: Icon(
                toId == null ? Icons.inbox_outlined : Icons.inventory_2_outlined,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              title: Text(_boxName(toId)),
              onTap: () => _pickDestination(toId),
            );
          }),
        ],
      ),
    );
  }
}
