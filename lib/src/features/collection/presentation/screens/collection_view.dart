import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_item_card.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
      ),
      body: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('No items in collection')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (items) {
              if (items.isEmpty) {
                return const Center(child: Text('No items in collection'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(Dimensions.sm),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.sm),
                    child: CollectionItemCard(
                      key: ValueKey(
                          '${item.cardId}_${item.setCode}_${item.setRarity}'),
                      item: item,
                    ),
                  );
                },
              );
            },
            error: (message) => Center(child: Text('Error: $message')),
          );
        },
      ),
    );
  }
}
