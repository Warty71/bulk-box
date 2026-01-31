import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/settings/settings_cubit.dart';
import 'package:ygo_collector/src/core/settings/settings_state.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_entry.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_view.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_options_button.dart';
import 'package:ygo_collector/src/features/sorting/domain/comparators/ygo_card_sorters.dart';
import 'package:ygo_collector/src/features/sorting/presentation/widgets/sort_button.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
        actions: [const SortButton(), const CollectionOptionsButton()],
      ),
      body: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (context, collectionState) {
          return collectionState.when(
            initial: () => const Center(child: Text('No items in collection')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (m) => Center(child: Text('Error: $m')),
            loaded: (collectionEntries) {
              if (collectionEntries.isEmpty) {
                return const Center(child: Text('No items in collection'));
              }

              return BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, settings) {
                  final sortedItems =
                      List<CollectionEntry>.from(collectionEntries);
                  sortCollectionItems(sortedItems, settings.sortOption);

                  return CollectionGridView(
                    collectionEntries: sortedItems,
                    showDividersBetweenSections: settings.showDividers,
                    sortOption: settings.sortOption,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
