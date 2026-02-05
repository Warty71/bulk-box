import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/database/app_database.dart' as db;
import 'package:bulk_box/src/core/settings/settings_cubit.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/add_card_bottom_sheet.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/collection_card_details_bottom_sheet.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/collection_options_bottom_sheet.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/move_to_bottom_sheet.dart';
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
  static Future<void> showAddCard(BuildContext context, {required db.Card card}) {
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
  static Future<void> showSort(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: settingsCubit,
        child: const SortBottomSheet(),
      ),
    );
  }
}
