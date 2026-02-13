import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_widgets_constants.dart';

/// "See More" button that expands a section to show more items.
class SearchSeeMoreButton extends StatelessWidget {
  final int remainingCount;
  final VoidCallback onTap;

  const SearchSeeMoreButton({
    super.key,
    required this.remainingCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showCount = remainingCount > searchSectionExpandIncrement
        ? searchSectionExpandIncrement
        : remainingCount;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.md,
        vertical: Dimensions.sm,
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.md,
            vertical: Dimensions.sm,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'See $showCount more',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: Dimensions.xs),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
