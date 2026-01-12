import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/enums/rarity.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_card_image.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_card_image_dialog.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_quantity_controls.dart';

class CollectionItemCard extends StatelessWidget {
  final CollectionItemEntity item;

  const CollectionItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rarityShort = Rarity.getShortRarity(item.setRarity);

    return Material(
      elevation: 1,
      color: theme.cardTheme.color ?? theme.colorScheme.surface,
      child: InkWell(
        onTap: () {
          CollectionCardImageDialog.show(context, item.cardId);
        },
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card Image - cached to prevent rebuilds
              CollectionCardImage(cardId: item.cardId),
              const SizedBox(width: Dimensions.sm),

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
                    const SizedBox(height: Dimensions.xs),

                    // Set Code
                    Text(
                      item.setCode,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            rarityShort,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: Dimensions.xs),

                    // Quantity Controls - inline with card info
                    CollectionQuantityControls(
                      cardId: item.cardId,
                      setCode: item.setCode,
                      setRarity: item.setRarity,
                      initialQuantity: item.quantity,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
