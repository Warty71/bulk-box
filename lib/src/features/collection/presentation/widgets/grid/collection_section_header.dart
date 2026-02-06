import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

class CollectionSectionHeader extends StatelessWidget {
  const CollectionSectionHeader({
    super.key,
    required this.title,
    required this.sortOption,
  });

  final String title;
  final SortOption sortOption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLetter = title.length == 1 && title != '#';

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimensions.md,
          Dimensions.lg,
          Dimensions.md,
          Dimensions.sm,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.md,
            vertical: Dimensions.sm,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.6,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radiusSm),
            border: Border(
              left: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.6),
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: isLetter ? 2 : 0,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
