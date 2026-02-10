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
import 'package:bulk_box/src/features/collection/presentation/widgets/dialogs/bulk_delete_confirmation_dialog.dart';

enum _BulkAction { move, delete }

/// App bar shown when in bulk selection mode.
/// Shows selected count, Cancel, Select all, and Actions menu.
class BulkActionSelectionBar extends StatefulWidget {
  const BulkActionSelectionBar({
    super.key,
    required this.collectionEntries,
    required this.currentBoxId,
    required this.currentBoxName,
  });

  final List<CollectionEntry> collectionEntries;
  final int? currentBoxId;
  final String currentBoxName;

  @override
  State<BulkActionSelectionBar> createState() => _BulkActionSelectionBarState();
}

class _BulkActionSelectionBarState extends State<BulkActionSelectionBar> {
  final _actionsKey = GlobalKey();

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
                        final allKeys = widget.collectionEntries
                            .map((e) => e.selectionKey)
                            .toSet();
                        cubit.selectAll(allKeys);
                      },
                      child: const Text('Select all'),
                    ),
                    if (selectedCount > 0)
                      TextButton.icon(
                        key: _actionsKey,
                        onPressed: () => _showActionsMenu(context),
                        icon: const Icon(Icons.arrow_drop_down, size: 20),
                        label: const Text('Actions'),
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

  void _showActionsMenu(BuildContext context) {
    final button =
        _actionsKey.currentContext!.findRenderObject()! as RenderBox;
    final overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final buttonPos = button.localToGlobal(Offset.zero, ancestor: overlay);
    final position = RelativeRect.fromLTRB(
      buttonPos.dx,
      buttonPos.dy + button.size.height,
      overlay.size.width - buttonPos.dx - button.size.width,
      0,
    );

    showMenu<_BulkAction>(
      context: context,
      position: position,
      items: [
        const PopupMenuItem(
          value: _BulkAction.move,
          child: ListTile(
            leading: Icon(Icons.drive_file_move_outline),
            title: Text('Move'),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        ),
        PopupMenuItem(
          value: _BulkAction.delete,
          child: ListTile(
            leading: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'Delete',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    ).then((action) {
      if (action == null || !context.mounted) return;
      switch (action) {
        case _BulkAction.move:
          _openMoveToSheet(context);
        case _BulkAction.delete:
          _deleteSelected(context);
      }
    });
  }

  void _openMoveToSheet(BuildContext context) {
    final bulkMoveCubit = context.read<BulkMoveCubit>();
    final collectionCubit = context.read<CollectionCubit>();
    final selectedKeys = bulkMoveCubit.state.selectedKeys;
    final entriesToMove = widget.collectionEntries
        .where((e) => selectedKeys.contains(e.selectionKey))
        .toList();
    if (entriesToMove.isEmpty) return;

    AppBottomSheets.showBulkMoveDestination(
      context,
      fromBoxId: widget.currentBoxId,
      fromBoxName: widget.currentBoxName,
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
            fromBoxId: widget.currentBoxId,
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

  Future<void> _deleteSelected(BuildContext context) async {
    final bulkMoveCubit = context.read<BulkMoveCubit>();
    final collectionCubit = context.read<CollectionCubit>();
    final selectedKeys = bulkMoveCubit.state.selectedKeys;
    final entriesToDelete = widget.collectionEntries
        .where((e) => selectedKeys.contains(e.selectionKey))
        .toList();
    if (entriesToDelete.isEmpty) return;

    final confirmed = await BulkDeleteConfirmationDialog.show(
      context,
      count: entriesToDelete.length,
    );
    if (confirmed != true || !context.mounted) return;

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
                'Deleting ${entriesToDelete.length} card${entriesToDelete.length == 1 ? '' : 's'}...',
                style: Theme.of(ctx).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );

    try {
      await collectionCubit.batchDeleteSlots(
        entriesToDelete
            .map((e) => (
                  cardId: e.card.id,
                  setCode: e.setCode,
                  setRarity: e.setRarity,
                  boxId: e.boxId,
                ))
            .toList(),
      );
      if (!context.mounted) return;
      bulkMoveCubit.exitSelectionMode();
      di.getIt<BoxesCubit>().loadBoxes();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete cards: $e')),
      );
    } finally {
      if (context.mounted) {
        AppRouter.rootNavigatorKey.currentState?.pop();
      }
    }
  }
}
