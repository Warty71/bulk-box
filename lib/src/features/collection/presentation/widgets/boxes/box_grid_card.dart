import 'package:flutter/material.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box_or_unboxed.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/boxes/box_card_tile.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/boxes/box_grid_card_with_count.dart';

/// Grid card for a box or Unboxed. Tactile tile: rounded card, elevation, gradient, tap scale.
class BoxGridCard extends StatelessWidget {
  final BoxOrUnboxed item;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const BoxGridCard({
    super.key,
    required this.item,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (item.isUnboxed) {
      return BoxCardTile(
        icon: Icons.inbox_outlined,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        title: 'Unboxed',
        subtitle: 'Items not in any box',
        onTap: onTap,
      );
    }

    return BoxGridCardWithCount(
      box: item.box!,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
