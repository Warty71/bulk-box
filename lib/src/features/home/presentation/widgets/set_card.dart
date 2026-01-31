import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/theme/theme_extensions.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/models/set_info_model.dart';

class SetCard extends StatelessWidget {
  const SetCard({
    super.key,
    required this.set,
  });

  final SetInfoModel set;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardStyles = theme.extension<CardStyles>()!;

    return Container(
      width: 120,
      height: 180,
      decoration: cardStyles.cardDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.radiusMd),
              ),
            ),
            child: set.setImage != null && set.setImage!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimensions.radiusMd),
                    ),
                    child: Image.network(
                      set.setImage!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: Dimensions.iconXl,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: Dimensions.iconXl,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.sm),
              child: Text(
                set.setName,
                style: theme.textTheme.labelLarge,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
