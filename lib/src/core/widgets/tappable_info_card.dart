import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';

/// A tappable card with icon, title, subtitle, and optional trailing action (e.g. menu or delete).
class TappableInfoCard extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  /// If null, no trailing action. If set, replaces the default delete button.
  final VoidCallback? onDelete;
  /// If set, shown instead of [onDelete] button (e.g. [PopupMenuButton]).
  final Widget? trailing;

  const TappableInfoCard({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.onDelete,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(Dimensions.radiusMd);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: backgroundColor,
                      child: Icon(
                        icon,
                        size: Dimensions.iconXl,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimensions.xs),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            if (trailing != null)
              Positioned(
                top: 0,
                right: 0,
                child: trailing!,
              )
            else if (onDelete != null)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                  style: IconButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
