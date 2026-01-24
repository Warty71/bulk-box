import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_card_image.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_card_image_dialog.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

class CollectionItemCard extends StatelessWidget {
  final YgoCard card;
  final int totalQuantity;

  const CollectionItemCard({
    super.key,
    required this.card,
    required this.totalQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.sm),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            CollectionCardImageDialog.show(context, card.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Image
                CollectionCardImage(cardId: card.id),

                const SizedBox(width: Dimensions.sm),

                // Card Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + Quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              card.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'x$totalQuantity',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.xs),

                      // Optional: small preview of sets/rarity
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: card.cardSets
                            .take(3)
                            .map(
                              (set) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  set.setRarity,
                                  style: theme.textTheme.labelSmall,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
