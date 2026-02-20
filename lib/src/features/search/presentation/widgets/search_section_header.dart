import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/repositories/image_repository.dart';
import 'package:bulk_box/src/features/ygo_cards/presentation/screens/card_details_screen.dart';

/// Section header showing card image, title, type, and stats.
/// Tappable to navigate to card details screen.
class SearchSectionHeader extends StatelessWidget {
  final YgoCard card;
  final String title;

  const SearchSectionHeader({
    super.key,
    required this.card,
    required this.title,
  });

  void _navigateToCardDetails(BuildContext context) {
    HapticFeedback.selectionClick();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CardDetailsScreen(card: card),
      ),
    );
  }

  bool get _isMonster =>
      card.atk != null || card.def != null || card.level != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imagePathFuture =
        di.getIt<ImageRepository>().getCardImagePath(card.id);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimensions.md,
          Dimensions.md,
          Dimensions.md,
          Dimensions.sm,
        ),
        child: Material(
          color: theme.colorScheme.surfaceContainerHighest
              .withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(Dimensions.radiusMd),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => _navigateToCardDetails(context),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.sm),
              child: Row(
                children: [
                  // Card image — proper aspect ratio, no crop
                  _CardImage(
                    imagePathFuture: imagePathFuture,
                    theme: theme,
                  ),
                  const SizedBox(width: Dimensions.md),
                  // Card info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card name
                        Text(
                          title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        // Race / Type line
                        Text(
                          _subtitleText,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Stats row (monsters only)
                        if (_isMonster) ...[
                          const SizedBox(height: Dimensions.xs),
                          _StatsRow(card: card, theme: theme),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimensions.xs),
                  // Chevron
                  Icon(
                    Icons.chevron_right_rounded,
                    color: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.4),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// e.g. "Warrior / DARK" or "Continuous Trap"
  String get _subtitleText {
    final parts = <String>[card.race];
    if (card.attribute != null) parts.add(card.attribute!);
    return parts.join('  /  ');
  }
}

// ---------------------------------------------------------------------------
// Private helper widgets
// ---------------------------------------------------------------------------

class _CardImage extends StatelessWidget {
  final Future<String> imagePathFuture;
  final ThemeData theme;

  const _CardImage({required this.imagePathFuture, required this.theme});

  static const _width = 48.0;
  static const _height = 70.0;
  static final _radius = BorderRadius.circular(Dimensions.radiusXs);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: imagePathFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: _radius,
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return ClipRRect(
            borderRadius: _radius,
            child: Image.asset(
              'assets/images/ygo_placeholder.jpg',
              width: _width,
              height: _height,
              fit: BoxFit.cover,
            ),
          );
        }

        return ClipRRect(
          borderRadius: _radius,
          child: Image.file(
            File(snapshot.data!),
            width: _width,
            height: _height,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Image.asset(
              'assets/images/ygo_placeholder.jpg',
              width: _width,
              height: _height,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

/// Compact stats row: Level / ATK / DEF shown as icon + value pairs.
class _StatsRow extends StatelessWidget {
  final YgoCard card;
  final ThemeData theme;

  const _StatsRow({required this.card, required this.theme});

  @override
  Widget build(BuildContext context) {
    final style = theme.textTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.onSurfaceVariant,
      fontSize: 11,
    );

    return Row(
      children: [
        if (card.level != null) ...[
          Icon(
            Icons.star_rounded,
            size: 14,
            color: Colors.amber.shade700,
          ),
          const SizedBox(width: 2),
          Text('${card.level}', style: style),
          const SizedBox(width: Dimensions.sm),
        ],
        if (card.atk != null) ...[
          Text(
            'ATK',
            style: style?.copyWith(
              fontSize: 9,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(width: 3),
          Text('${card.atk}', style: style),
          const SizedBox(width: Dimensions.sm),
        ],
        if (card.def != null) ...[
          Text(
            'DEF',
            style: style?.copyWith(
              fontSize: 9,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(width: 3),
          Text('${card.def}', style: style),
        ],
      ],
    );
  }
}
