import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/settings/settings_cubit.dart';
import 'package:bulk_box/src/core/widgets/app_dialogs.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/bottom_sheets/add_card_bottom_sheet.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/bottom_sheets/box_options_bottom_sheet.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/bottom_sheets/collection_card_details_bottom_sheet.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/bottom_sheets/collection_options_bottom_sheet.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/bottom_sheets/bulk_move_destination_bottom_sheet.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/bottom_sheets/move_to_bottom_sheet.dart';
import 'package:bulk_box/src/features/sorting/presentation/widgets/sort_bottom_sheet.dart';

/// Shared options for showing bottom sheets.
const _defaultOptions = _BottomSheetOptions(
  isScrollControlled: true,
  useSafeArea: true,
);

class _BottomSheetOptions {
  const _BottomSheetOptions({
    required this.isScrollControlled,
    required this.useSafeArea,
  });
  final bool isScrollControlled;
  final bool useSafeArea;
}

/// Single entry point for showing app bottom sheets.
/// Keeps presentation (modal options, safe area) consistent and reusable.
class AppBottomSheets {
  AppBottomSheets._();

  /// Shows the card details sheet (slots per box, Save, Move to...).
  static Future<void> showCardDetails(
    BuildContext context, {
    required CollectionEntry entry,
    required CollectionCubit collectionCubit,
    int? currentBoxId,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: _defaultOptions.isScrollControlled,
      useSafeArea: _defaultOptions.useSafeArea,
      builder: (_) => CollectionCardDetailsBottomSheet(
        entry: entry,
        collectionCubit: collectionCubit,
        currentBoxId: currentBoxId,
      ),
    );
  }

  /// Shows the bulk-move destination picker (move selected cards to one box).
  static Future<void> showBulkMoveDestination(
    BuildContext context, {
    required int? fromBoxId,
    required String fromBoxName,
    required int selectedCount,
    required void Function(int? toBoxId) onMoveTo,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: _defaultOptions.isScrollControlled,
      useSafeArea: _defaultOptions.useSafeArea,
      builder: (_) => BulkMoveDestinationBottomSheet(
        fromBoxId: fromBoxId,
        fromBoxName: fromBoxName,
        selectedCount: selectedCount,
        onMoveTo: onMoveTo,
      ),
    );
  }

  /// Shows the move-to sheet (distribute quantity from one box to others).
  static Future<void> showMoveTo(
    BuildContext context, {
    required int? fromBoxId,
    required int fromQuantity,
    required String fromBoxName,
    required Future<void> Function(int? toBoxId, int amount) onMove,
    required VoidCallback onDone,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: _defaultOptions.isScrollControlled,
      builder: (_) => MoveToBottomSheet(
        fromBoxId: fromBoxId,
        fromQuantity: fromQuantity,
        fromBoxName: fromBoxName,
        onMove: onMove,
        onDone: onDone,
      ),
    );
  }

  /// Shows the add-card sheet (set/rarity quantities, save to Unboxed).
  static Future<void> showAddCard(BuildContext context, {required YgoCard card}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: _defaultOptions.isScrollControlled,
      useSafeArea: _defaultOptions.useSafeArea,
      builder: (_) => AddCardBottomSheet(card: card),
    );
  }

  /// Shows the collection options sheet (dividers, etc.).
  static Future<void> showCollectionOptions(BuildContext context) {
    final collectionCubit = context.read<CollectionCubit>();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: _defaultOptions.isScrollControlled,
      useSafeArea: _defaultOptions.useSafeArea,
      builder: (_) => BlocProvider.value(
        value: collectionCubit,
        child: const CollectionOptionsBottomSheet(),
      ),
    );
  }

  /// Shows the sort options sheet (Name A–Z, Card Type, etc.).
  static Future<void> showSort(BuildContext context, {String? boxKey}) {
    final settingsCubit = context.read<SettingsCubit>();
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: settingsCubit,
        child: SortBottomSheet(boxKey: boxKey),
      ),
    );
  }

  /// Shows the box options sheet (Edit name, Delete).
  /// After the sheet closes, the chosen action is executed using the
  /// caller's [context] which still has [BoxesCubit] in the tree.
  static Future<void> showBoxOptions(
    BuildContext context, {
    required Box box,
  }) async {
    final action = await showModalBottomSheet<BoxOptionAction>(
      context: context,
      isScrollControlled: _defaultOptions.isScrollControlled,
      useSafeArea: _defaultOptions.useSafeArea,
      builder: (_) => BoxOptionsBottomSheet(box: box),
    );

    if (action == null || !context.mounted) return;

    switch (action) {
      case BoxOptionAction.edit:
        AppDialogs.showEditBox(context, box: box);
      case BoxOptionAction.delete:
        AppDialogs.showDeleteBoxConfirmation(context, box: box);
    }
  }
}
