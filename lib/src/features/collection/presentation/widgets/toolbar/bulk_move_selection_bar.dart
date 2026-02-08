import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/router/app_router.dart';
import 'package:bulk_box/src/core/widgets/app_bottom_sheets.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/bulk_move_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/bulk_move_state.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';

/// App bar shown when in bulk move selection mode.
/// Shows selected count, Cancel, Select all, and Move actions.
class BulkMoveSelectionBar extends StatelessWidget {
  const BulkMoveSelectionBar({
    super.key,
    required this.collectionEntries,
    required this.currentBoxId,
    required this.currentBoxName,
  });

  final List<CollectionEntry> collectionEntries;
  final int? currentBoxId;
  final String currentBoxName;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BulkMoveCubit, BulkMoveState, int>(
      selector: (state) => state.selectedCount,
      builder: (context, selectedCount) {
        final cubit = context.read<BulkMoveCubit>();
        return Material(
          elevation: 1,
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 48,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.xs),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        cubit.exitSelectionMode();
                      },
                    ),
                    const SizedBox(width: Dimensions.xs),
                    Text(
                      '$selectedCount selected',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        final allKeys = collectionEntries
                            .map((e) => e.selectionKey)
                            .toSet();
                        cubit.selectAll(allKeys);
                      },
                      child: const Text('Select all'),
                    ),
                    if (selectedCount > 0)
                      TextButton.icon(
                        onPressed: () => _openMoveToSheet(context),
                        icon: const Icon(Icons.drive_file_move_outline,
                            size: 20),
                        label: const Text('Move'),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _openMoveToSheet(BuildContext context) {
    final bulkMoveCubit = context.read<BulkMoveCubit>();
    final collectionCubit = context.read<CollectionCubit>();
    final selectedKeys = bulkMoveCubit.state.selectedKeys;
    final entriesToMove = collectionEntries
        .where((e) => selectedKeys.contains(e.selectionKey))
        .toList();
    if (entriesToMove.isEmpty) return;

    AppBottomSheets.showBulkMoveDestination(
      context,
      fromBoxId: currentBoxId,
      fromBoxName: currentBoxName,
      selectedCount: entriesToMove.length,
      onMoveTo: (toBoxId) async {
        if (!context.mounted) return;
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          useRootNavigator: true,
          builder: (ctx) => PopScope(
            canPop: false,
            child: AlertDialog(
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(width: 24),
                  Text(
                    'Moving ${entriesToMove.length} card${entriesToMove.length == 1 ? '' : 's'}...',
                    style: Theme.of(ctx).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        );

        try {
          await collectionCubit.batchMoveBetweenSlots(
            items: entriesToMove
                .map((e) => (
                      cardId: e.card.id,
                      setCode: e.setCode,
                      setRarity: e.setRarity,
                      quantity: e.quantity,
                    ))
                .toList(),
            fromBoxId: currentBoxId,
            toBoxId: toBoxId,
          );
          if (!context.mounted) return;
          bulkMoveCubit.exitSelectionMode();
          di.getIt<BoxesCubit>().loadBoxes();
        } catch (e) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to move cards: $e')),
          );
        } finally {
          if (context.mounted) {
            AppRouter.rootNavigatorKey.currentState?.pop();
          }
        }
      },
    );
  }
}
