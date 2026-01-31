import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item_with_card.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_view.dart';
import 'package:ygo_collector/src/features/sorting/domain/comparators/ygo_card_sorters.dart';
import 'package:ygo_collector/src/features/sorting/presentation/cubits/sort_cubit.dart';
import 'package:ygo_collector/src/features/sorting/presentation/widgets/sort_button.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
        actions: [const SortButton()],
      ),
      body: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No items in collection')),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (m) => Center(child: Text('Error: $m')),
            loaded: (itemsWithCards) {
              if (itemsWithCards.isEmpty) {
                return const Center(child: Text('No items in collection'));
              }

              // Get current sort option
              final sortOption = context.select(
                (SortCubit cubit) => cubit.state.option,
              );

              // Apply sorting
              final sortedItems =
                  List<CollectionItemWithCard>.from(itemsWithCards);

              sortCollectionItems(sortedItems, sortOption);

              return CollectionGridView(itemsWithCards: sortedItems);
            },
          );
        },
      ),
    );
  }
}
