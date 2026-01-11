import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/di/injection_container.dart' as di;
import 'package:ygo_collector/src/core/enums/rarity.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:ygo_collector/src/features/search/presentation/cubit/search_cubit.dart';
import 'dart:io';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.getIt<CollectionCubit>()..loadCollectionItems(),
        ),
        BlocProvider(
          create: (context) => di.getIt<SearchCubit>(),
        ),
      ],
      child: const CollectionView(),
    );
  }
}

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
                    child: _CollectionItemCard(
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

class _CollectionItemCard extends StatelessWidget {
  final CollectionItemEntity item;

  const _CollectionItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rarityShort = Rarity.getShortRarity(item.setRarity);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Image - cached to prevent rebuilds
                _CardImage(cardId: item.cardId),
                const SizedBox(width: Dimensions.md),

                // Card Info - static, doesn't change
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Name - max 2 lines with ellipsis
                      Text(
                        item.cardName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Dimensions.sm),

                      // Set Code
                      Text(
                        item.setCode,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Dimensions.xs),

                      // Rarity with abbreviation
                      Row(
                        children: [
                          Text(
                            item.setRarity,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(width: Dimensions.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.xs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              rarityShort,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: Dimensions.md),

            // Quantity Controls - only this part rebuilds when quantity changes
            _QuantityControls(
              cardId: item.cardId,
              setCode: item.setCode,
              setRarity: item.setRarity,
              initialQuantity: item.quantity,
            ),
          ],
        ),
      ),
    );
  }
}

/// Cached image widget that prevents rebuilds
class _CardImage extends StatefulWidget {
  final int cardId;

  const _CardImage({required this.cardId});

  @override
  State<_CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<_CardImage> {
  Future<String>? _imagePathFuture;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    final searchCubit = context.read<SearchCubit>();
    _imagePathFuture = searchCubit.getCardImagePath(widget.cardId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.radiusSm),
      child: SizedBox(
        width: 80,
        height: 112,
        child: FutureBuilder<String>(
          future: _imagePathFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

            if (snapshot.hasData) {
              return Image.file(
                File(snapshot.data!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/ygo_placeholder.jpg',
                    fit: BoxFit.cover,
                  );
                },
              );
            }

            return Image.asset(
              'assets/images/ygo_placeholder.jpg',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}

/// Quantity controls that only rebuild when quantity changes
class _QuantityControls extends StatelessWidget {
  final int cardId;
  final String setCode;
  final String setRarity;
  final int initialQuantity;

  const _QuantityControls({
    required this.cardId,
    required this.setCode,
    required this.setRarity,
    required this.initialQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CollectionCubit, CollectionState>(
      buildWhen: (previous, current) {
        // Only rebuild if this specific item's quantity changed
        final previousItems = previous.maybeWhen(
          loaded: (items) => items,
          orElse: () => <CollectionItemEntity>[],
        );
        final currentItems = current.maybeWhen(
          loaded: (items) => items,
          orElse: () => <CollectionItemEntity>[],
        );

        if (currentItems.isEmpty) return false;

        final previousItem = previousItems.firstWhere(
          (item) =>
              item.cardId == cardId &&
              item.setCode == setCode &&
              item.setRarity == setRarity,
          orElse: () => CollectionItemEntity(
            cardId: cardId,
            cardName: '',
            setCode: setCode,
            setRarity: setRarity,
            quantity: initialQuantity,
            dateAdded: DateTime.now(),
          ),
        );

        final currentItem = currentItems.firstWhere(
          (item) =>
              item.cardId == cardId &&
              item.setCode == setCode &&
              item.setRarity == setRarity,
          orElse: () => CollectionItemEntity(
            cardId: cardId,
            cardName: '',
            setCode: setCode,
            setRarity: setRarity,
            quantity: initialQuantity,
            dateAdded: DateTime.now(),
          ),
        );

        return previousItem.quantity != currentItem.quantity;
      },
      builder: (context, state) {
        // Get current quantity from state
        final items = state.maybeWhen(
          loaded: (items) => items,
          orElse: () => <CollectionItemEntity>[],
        );

        int currentQuantity = initialQuantity;
        if (items.isNotEmpty) {
          final item = items.firstWhere(
            (item) =>
                item.cardId == cardId &&
                item.setCode == setCode &&
                item.setRarity == setRarity,
            orElse: () => CollectionItemEntity(
              cardId: cardId,
              cardName: '',
              setCode: setCode,
              setRarity: setRarity,
              quantity: initialQuantity,
              dateAdded: DateTime.now(),
            ),
          );
          currentQuantity = item.quantity;
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.xs),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(Dimensions.radiusSm),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                iconSize: Dimensions.iconMd,
                onPressed: () {
                  context.read<CollectionCubit>().removeCollectionItem(
                        cardId,
                        setCode,
                        setRarity,
                      );
                },
              ),
              Text(
                '$currentQuantity',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                iconSize: Dimensions.iconMd,
                onPressed: () {
                  context.read<CollectionCubit>().updateQuantity(
                        cardId,
                        setCode,
                        setRarity,
                        currentQuantity + 1,
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
