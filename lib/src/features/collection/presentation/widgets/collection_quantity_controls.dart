import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';

/// Quantity controls that only rebuild when quantity changes
class CollectionQuantityControls extends StatelessWidget {
  final int cardId;
  final String setCode;
  final String setRarity;
  final int initialQuantity;

  const CollectionQuantityControls({
    super.key,
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
          loaded: (items, viewMode) => items,
          orElse: () => <CollectionItemEntity>[],
        );
        final currentItems = current.maybeWhen(
          loaded: (items, viewMode) => items,
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
          loaded: (items, viewMode) => items,
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

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              iconSize: Dimensions.iconSm,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              onPressed: () {
                context.read<CollectionCubit>().removeCollectionItem(
                      cardId,
                      setCode,
                      setRarity,
                    );
              },
            ),
            SizedBox(
              width: 28,
              child: Text(
                '$currentQuantity',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              iconSize: Dimensions.iconSm,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
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
        );
      },
    );
  }
}
