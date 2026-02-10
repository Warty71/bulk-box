import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/enums/rarity.dart';
import 'package:bulk_box/src/core/utils/set_code_utils.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/bulk_move_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/bulk_move_state.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';

/// Grid item widget for displaying a card in the collection grid view.
/// Selection state (isSelectionMode, isSelected) is read from [BulkMoveCubit]
/// so only this item rebuilds when its selection changes.
/// Scales down on press; fires selection after a hold delay with haptic feedback.
class CollectionGridItem extends StatefulWidget {
  final CollectionEntry entry;
  final int totalQuantity;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const CollectionGridItem({
    super.key,
    required this.entry,
    required this.totalQuantity,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<CollectionGridItem> createState() => _CollectionGridItemState();
}

class _CollectionGridItemState extends State<CollectionGridItem> {
  bool _pressed = false;
  bool _cancelled = false;
  Timer? _selectionTimer;
  Offset? _downPosition;
  DateTime? _downTime;
  /// Hold duration before long-press selection fires.
  static const _selectionDelayMs = 500;
  static const _scaleWhenPressed = 0.97;
  static const _scaleDurationMs = 120;
  /// Max drift (px) before the hold is treated as a scroll.
  static const _moveSlop = 10.0;
  /// Max press duration (ms) to still count as a tap.
  static const _tapThresholdMs = 200;

  late final Future<String> _imagePathFuture;

  @override
  void initState() {
    super.initState();
    _imagePathFuture =
        di.getIt<SearchRepository>().getCardImagePath(widget.entry.card.id);
  }

  @override
  void dispose() {
    _selectionTimer?.cancel();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    if (widget.onLongPress == null) return;
    _downPosition = event.position;
    _downTime = DateTime.now();
    _cancelled = false;
    setState(() => _pressed = true);
    _selectionTimer?.cancel();
    _selectionTimer = Timer(const Duration(milliseconds: _selectionDelayMs), () {
      if (!mounted) return;
      HapticFeedback.mediumImpact();
      widget.onLongPress!();
      _clearHold();
    });
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_downPosition == null) return;
    if ((event.position - _downPosition!).distance > _moveSlop) {
      _cancelled = true;
      _clearHold();
    }
  }

  void _onPointerUp(PointerUpEvent _) {
    final wasQuickTap = !_cancelled &&
        _downTime != null &&
        DateTime.now().difference(_downTime!).inMilliseconds < _tapThresholdMs;
    _clearHold();
    if (wasQuickTap && widget.onTap != null) {
      HapticFeedback.selectionClick();
      widget.onTap!();
    }
  }

  void _onPointerCancel(PointerCancelEvent _) => _clearHold();

  void _clearHold() {
    _selectionTimer?.cancel();
    _selectionTimer = null;
    if (_pressed) setState(() => _pressed = false);
  }

  static Widget _badge(
    BuildContext context, {
    required String label,
    Color? backgroundColor,
  }) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final fg = theme.colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BulkMoveCubit, BulkMoveState, (bool, bool)>(
      selector: (state) => (
        state.isSelectionMode,
        state.selectedKeys.contains(widget.entry.selectionKey),
      ),
      builder: (context, selection) {
        final isSelectionMode = selection.$1;
        final isSelected = selection.$2;
        return _buildCard(context,
            isSelectionMode: isSelectionMode, isSelected: isSelected);
      },
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required bool isSelectionMode,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    final hasLongPress = widget.onLongPress != null;

    Widget card = Card(
      margin: EdgeInsets.zero,
      elevation: isSelectionMode && isSelected ? 2 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: isSelectionMode && isSelected
            ? BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: hasLongPress ? null : (widget.onTap != null
            ? () {
                HapticFeedback.selectionClick();
                widget.onTap!();
              }
            : null),
        onLongPress: hasLongPress ? null : widget.onLongPress,
        child: Stack(
          children: [
            // Card Image (future cached so setState doesn't recreate it and flicker)
            FutureBuilder<String>(
              future: _imagePathFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return Image.asset(
                    'assets/images/ygo_placeholder.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                  );
                }

                return Image.file(
                  File(snapshot.data!),
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/ygo_placeholder.jpg',
                      fit: BoxFit.contain,
                      width: double.infinity,
                    );
                  },
                );
              },
            ),
            // Print cluster: set + rarity in a row (bottom-left)
            Positioned(
              left: 8,
              bottom: 8,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _badge(context, label: shortSetCode(widget.entry.setCode)),
                  const SizedBox(width: 4),
                  _badge(context,
                      label: Rarity.getShortRarity(widget.entry.setRarity)),
                ],
              ),
            ),
            // Quantity Badge
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'x${widget.totalQuantity}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Selection checkmark (bulk move mode)
            if (isSelectionMode && isSelected)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check,
                    size: 18,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (hasLongPress) {
      card = Listener(
        onPointerDown: _onPointerDown,
        onPointerMove: _onPointerMove,
        onPointerUp: _onPointerUp,
        onPointerCancel: _onPointerCancel,
        child: AnimatedScale(
          scale: _pressed ? _scaleWhenPressed : 1.0,
          duration: const Duration(milliseconds: _scaleDurationMs),
          curve: Curves.easeInOut,
          child: card,
        ),
      );
    }

    return card;
  }
}
