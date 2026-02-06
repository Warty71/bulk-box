import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';

/// A single box card tile: rounded, elevated, gradient, scale-on-tap.
class BoxCardTile extends StatefulWidget {
  final IconData icon;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  const BoxCardTile({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
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

  Widget _buildContent(ThemeData theme) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: Dimensions.iconXl,
                color: _iconColor(theme, widget.backgroundColor),
              ),
              const SizedBox(height: Dimensions.sm),
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
