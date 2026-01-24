import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_view.dart';

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
            error: (m) => Center(child: Text('Error: $m')),
            loaded: (items) {
              if (items.isEmpty) {
                return const Center(child: Text('No items in collection'));
              }

              return CollectionGridView(items: items);
            },
          );
        },
      ),
    );
  }
}
