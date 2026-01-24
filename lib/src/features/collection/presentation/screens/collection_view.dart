import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/di/injection_container.dart' as di;
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_grid_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_item_card.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';
import 'package:ygo_collector/src/features/search/domain/repositories/search_repository.dart';

enum CollectionViewMode { list, grid }

class CollectionView extends StatefulWidget {
  const CollectionView({super.key});

  @override
  State<CollectionView> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  CollectionViewMode _viewMode = CollectionViewMode.list;

  void _toggleViewMode() {
    setState(() {
      _viewMode = _viewMode == CollectionViewMode.list
          ? CollectionViewMode.grid
          : CollectionViewMode.list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
        actions: [
          IconButton(
            icon: Icon(
              _viewMode == CollectionViewMode.list
                  ? Icons.grid_view
                  : Icons.list,
            ),
            onPressed: _toggleViewMode,
            tooltip: _viewMode == CollectionViewMode.list
                ? 'Grid View'
                : 'List View',
          ),
        ],
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

              return _viewMode == CollectionViewMode.list
                  ? _buildListView(items)
                  : _buildGridView(items);
            },
            error: (message) => Center(child: Text('Error: $message')),
          );
        },
      ),
    );
  }

  Widget _buildListView(List<CollectionItemEntity> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(Dimensions.sm),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.sm),
          child: CollectionItemCard(
            key: ValueKey('${item.cardId}_${item.setCode}_${item.setRarity}'),
            item: item,
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<CollectionItemEntity> items) {
    // Group items by cardId to get unique cards
    final uniqueCardIds = <int>{};
    final Map<int, int> cardQuantities = {};

    for (final item in items) {
      uniqueCardIds.add(item.cardId);
      cardQuantities[item.cardId] =
          (cardQuantities[item.cardId] ?? 0) + item.quantity;
    }

    return FutureBuilder<_GridLoadResult>(
      future: _loadCardsForGrid(uniqueCardIds.toList()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error loading cards: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.cards.isEmpty) {
          final failedCount = snapshot.data?.failedCardIds.length ?? 0;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No cards to display'),
                if (failedCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.sm),
                    child: Text(
                      'Failed to load $failedCount card(s)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
              ],
            ),
          );
        }

        final result = snapshot.data!;

        return Column(
          children: [
            if (result.failedCardIds.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(Dimensions.sm),
                color: Theme.of(context).colorScheme.errorContainer,
                child: Text(
                  'Warning: ${result.failedCardIds.length} card(s) could not be loaded from the API',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                ),
              ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(Dimensions.md),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.686,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: result.cards.length,
                itemBuilder: (context, index) {
                  final card = result.cards[index];
                  final totalQuantity = cardQuantities[card.id] ?? 0;

                  return CollectionGridItem(
                    key: ValueKey(card.id),
                    card: card,
                    totalQuantity: totalQuantity,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<_GridLoadResult> _loadCardsForGrid(List<int> cardIds) async {
    final searchRepository = di.getIt<SearchRepository>();
    final cards = <YgoCard>[];
    final failedCardIds = <int>[];

    for (final cardId in cardIds) {
      try {
        final card = await searchRepository.getCardDetails(cardId);
        cards.add(card);
      } catch (e) {
        // Track cards that fail to load
        failedCardIds.add(cardId);
        debugPrint('Failed to load card $cardId: $e');
      }
    }

    return _GridLoadResult(cards: cards, failedCardIds: failedCardIds);
  }
}

class _GridLoadResult {
  final List<YgoCard> cards;
  final List<int> failedCardIds;

  _GridLoadResult({required this.cards, required this.failedCardIds});
}
