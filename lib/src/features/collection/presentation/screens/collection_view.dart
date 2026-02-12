import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bulk_box/src/core/widgets/app_bottom_sheets.dart';
import 'package:bulk_box/src/core/settings/settings_cubit.dart';
import 'package:bulk_box/src/core/settings/settings_state.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/bulk_move_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/bulk_move_state.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/grid/collection_grid_view.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/toolbar/bulk_move_selection_bar.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/toolbar/collection_search_bar.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/toolbar/collection_search_button.dart';
import 'package:bulk_box/src/features/sorting/domain/comparators/ygo_card_sorters.dart';
import 'package:bulk_box/src/features/sorting/presentation/widgets/sort_button.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BulkMoveCubit, BulkMoveState>(
      buildWhen: (prev, curr) =>
          prev.isSelectionMode != curr.isSelectionMode,
      builder: (context, bulkState) {
        final inSelectionMode = bulkState.isSelectionMode;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: BlocSelector<CollectionCubit, CollectionState, String>(
              selector: (state) => state.maybeWhen(
                loaded: (_, __, ___, ____, boxName) =>
                    boxName ?? 'My Collection',
                orElse: () => 'My Collection',
              ),
              builder: (context, title) => Text(title),
            ),
            actions: [
              BlocSelector<CollectionCubit, CollectionState, String?>(
                selector: (state) => state.maybeWhen(
                  loaded: (_, __, ___, boxId, boxName) =>
                      boxId?.toString() ??
                      (boxName == 'Unboxed' ? 'unboxed' : null),
                  orElse: () => null,
                ),
                builder: (context, boxKey) => SortButton(boxKey: boxKey),
              ),
            ],
          ),
          body: Column(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: inSelectionMode
                    ? const _BulkMoveSelectionStrip()
                    : const SizedBox.shrink(),
              ),
              const Expanded(child: _CollectionBody()),
            ],
          ),
          floatingActionButton: inSelectionMode
              ? null
              : const CollectionSearchButton(),
        );
      },
    );
  }
}

/// Strip below the app bar when in bulk selection mode.
/// [BulkActionSelectionBar] manages its own reactivity via BlocSelector.
class _BulkMoveSelectionStrip extends StatelessWidget {
  const _BulkMoveSelectionStrip();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CollectionCubit, CollectionState,
        (List<CollectionEntry>, int?, String?)>(
      selector: (state) => state.maybeWhen(
        loaded: (entries, _, __, boxId, boxName) =>
            (entries, boxId, boxName),
        orElse: () => (const [], null, null),
      ),
      builder: (context, tuple) => BulkActionSelectionBar(
        collectionEntries: tuple.$1,
        currentBoxId: tuple.$2,
        currentBoxName: tuple.$3 ?? 'Unboxed',
      ),
    );
  }
}

class _CollectionBody extends StatelessWidget {
  const _CollectionBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionCubit, CollectionState>(
      buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: Text('No items in collection')),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (m) => Center(child: Text('Error: $m')),
          loaded: (_, __, ___, ____, _____) => const _LoadedCollection(),
        );
      },
    );
  }
}

class _LoadedCollection extends StatelessWidget {
  const _LoadedCollection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _SearchBarSection(),
        Expanded(child: _GridSection()),
      ],
    );
  }
}

class _SearchBarSection extends StatelessWidget {
  const _SearchBarSection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CollectionCubit, CollectionState, bool>(
      selector: (state) => state.maybeWhen(
        loaded: (_, visible, __, ___, ____) => visible,
        orElse: () => false,
      ),
      builder: (context, searchBarVisible) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: searchBarVisible
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: CollectionSearchBar(),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

class _GridSection extends StatelessWidget {
  const _GridSection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CollectionCubit, CollectionState,
        (List<CollectionEntry>, String?)>(
      selector: (state) => state.maybeWhen(
        loaded: (entries, __, ___, boxId, boxName) => (
          entries,
          boxId?.toString() ?? (boxName == 'Unboxed' ? 'unboxed' : null),
        ),
        orElse: () => (const [], null),
      ),
      builder: (context, tuple) {
        final (collectionEntries, boxKey) = tuple;
        if (collectionEntries.isEmpty) {
          return const Center(child: Text('No items in collection'));
        }

        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settings) {
            final settingsCubit = context.read<SettingsCubit>();
            final sortOption = settingsCubit.effectiveSortOption(boxKey);
            final sortedItems =
                List<CollectionEntry>.from(collectionEntries);
            sortCollectionItems(sortedItems, sortOption);

            return CollectionGridView(
              collectionEntries: sortedItems,
              showDividersBetweenSections: settings.showDividers,
              sortOption: sortOption,
              onEntryTap: (entry) {
                final bulkMoveCubit = context.read<BulkMoveCubit>();
                if (bulkMoveCubit.state.isSelectionMode) {
                  bulkMoveCubit.toggleSelection(entry.selectionKey);
                } else {
                  _openCardDetails(context, entry);
                }
              },
              onEntryLongPress: (entry) {
                final bulkMoveCubit = context.read<BulkMoveCubit>();
                if (bulkMoveCubit.state.isSelectionMode) {
                  bulkMoveCubit.toggleSelection(entry.selectionKey);
                } else {
                  bulkMoveCubit.enterSelectionMode(entry.selectionKey);
                }
              },
            );
          },
        );
      },
    );
  }

  void _openCardDetails(BuildContext context, CollectionEntry entry) {
    final collectionCubit = context.read<CollectionCubit>();
    final state = collectionCubit.state;
    final currentBoxId = state.maybeWhen(
      loaded: (_, __, ___, boxId, ____) => boxId,
      orElse: () => null,
    );
    AppBottomSheets.showCardDetails(
      context,
      entry: entry,
      collectionCubit: collectionCubit,
      currentBoxId: currentBoxId,
    );
  }
}
