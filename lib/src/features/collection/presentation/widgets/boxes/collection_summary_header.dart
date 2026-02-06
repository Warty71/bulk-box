import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';

/// Compact header for the boxes grid: "Your Collection" and "X cards • Y boxes".
class CollectionSummaryHeader extends StatelessWidget {
  final int totalCards;
  final int boxCount;

  const CollectionSummaryHeader({
    super.key,
    required this.totalCards,
    required this.boxCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.md,
        vertical: Dimensions.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your Collection',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: Dimensions.xs),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.15),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: Text(
              _formatStats(totalCards, boxCount),
              key: ValueKey('$totalCards-$boxCount'),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatStats(int totalCards, int boxCount) {
    final cardPart = '$totalCards card${totalCards == 1 ? '' : 's'}';
    final boxPart = '$boxCount box${boxCount == 1 ? '' : 'es'}';
    return '$cardPart • $boxPart';
  }
}
