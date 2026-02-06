import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';

/// A single box card tile: rounded, elevated, gradient, scale-on-tap.
/// When [previewCardIds] has cards, they replace the icon; when empty or null, the icon is shown.
class BoxCardTile extends StatefulWidget {
  final IconData icon;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  /// First N card IDs to show as mini preview thumbnails (e.g. 2–3). Null = no previews.
  final List<int>? previewCardIds;

  const BoxCardTile({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.previewCardIds,
  });

  @override
  State<BoxCardTile> createState() => BoxCardTileState();
}

class BoxCardTileState extends State<BoxCardTile> {
  bool _pressed = false;

  static const double _cardRadius = Dimensions.radiusXl;
  static const double _elevation = 2.5;
  static const int _scaleDurationMs = 80;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: _scaleDurationMs),
        curve: Curves.easeInOut,
        child: Material(
          elevation: _elevation,
          shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(_cardRadius),
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _buildGradientBackground(),
              _buildFoilOverlay(),
              _buildContent(theme),
              if (widget.trailing != null) _buildTrailing(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.backgroundColor,
              _lighten(widget.backgroundColor, 0.08),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoilOverlay() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(-0.6, -0.8),
              end: const Alignment(0.8, 0.6),
              colors: [
                Colors.white.withValues(alpha: 0.06),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const double _previewCardWidth = 48.0;
  static const double _previewCardHeight = 70.0; // ~0.68 aspect
  static const double _previewOverlap = 18.0;

  Widget _buildContent(ThemeData theme) {
    final hasPreviews = widget.previewCardIds != null &&
        widget.previewCardIds!.isNotEmpty;

    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasPreviews) ...[
                Center(child: _buildPreviewStack()),
                const SizedBox(height: Dimensions.sm),
              ] else ...[
                Icon(
                  widget.icon,
                  size: Dimensions.iconXl,
                  color: _iconColor(theme, widget.backgroundColor),
                ),
                const SizedBox(height: Dimensions.sm),
              ],
              Text(
                widget.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _textColor(theme, widget.backgroundColor, true),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Dimensions.xs),
              Text(
                widget.subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _textColor(theme, widget.backgroundColor, false),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewStack() {
    final ids = widget.previewCardIds!.take(3).toList();
    const rotations = [-6.0, 0.0, 6.0];
    const stackWidth =
        _previewCardWidth * 3 - _previewOverlap * 2; // ~108
    return SizedBox(
      width: stackWidth,
      height: _previewCardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(ids.length, (i) {
          final left = i * (_previewCardWidth - _previewOverlap);
          return Positioned(
            left: left,
            top: 0,
            child: Transform.rotate(
              angle: rotations[i % 3] * 3.14159 / 180,
              child: _MiniCardThumbnail(
                cardId: ids[i],
                width: _previewCardWidth,
                height: _previewCardHeight,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTrailing() {
    return Positioned(
      top: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: widget.trailing!,
      ),
    );
  }

  Color _lighten(Color color, double amount) {
    return Color.lerp(color, Colors.white, amount.clamp(0.0, 1.0)) ?? color;
  }

  Color _iconColor(ThemeData theme, Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5
        ? theme.colorScheme.onSurface.withValues(alpha: 0.85)
        : Colors.white.withValues(alpha: 0.9);
  }

  Color _textColor(ThemeData theme, Color backgroundColor, bool isTitle) {
    return backgroundColor.computeLuminance() > 0.5
        ? (isTitle
            ? theme.colorScheme.onSurface.withValues(alpha: 0.9)
            : theme.colorScheme.onSurfaceVariant)
        : (isTitle
            ? Colors.white.withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.8));
  }
}

class _MiniCardThumbnail extends StatelessWidget {
  final int cardId;
  final double width;
  final double height;

  const _MiniCardThumbnail({
    required this.cardId,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final searchRepo = di.getIt<SearchRepository>();

    return SizedBox(
      width: width,
      height: height,
      child: FutureBuilder<String>(
        future: searchRepo.getCardImagePath(cardId),
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            child = Image.file(
              File(snapshot.data!),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _placeholder(context),
            );
          } else {
            child = _placeholder(context);
          }
          return child;
        },
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.credit_card,
          size: width * 0.4,
          color: Colors.white54,
        ),
      ),
    );
  }
}
