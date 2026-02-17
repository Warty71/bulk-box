import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/enums/rarity.dart';
import 'package:bulk_box/src/core/widgets/quantity_stepper.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';

/// Compact tile for a search result entry (set/rarity variant).
/// Shows set code, rarity, owned quantity, and quantity stepper.
class SearchListItem extends StatefulWidget {
  final SearchResultEntry entry;

  const SearchListItem({super.key, required this.entry});

  @override
  State<SearchListItem> createState() => _SearchListItemState();
}

class _SearchListItemState extends State<SearchListItem> {
  Future<int>? _ownedQuantityFuture;
  int? _cachedOwnedQuantity;

  @override
  void initState() {
    super.initState();
    _loadOwnedQuantity();
  }

  @override
  void didUpdateWidget(SearchListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry.selectionKey != widget.entry.selectionKey) {
      _loadOwnedQuantity();
    }
  }

  void _loadOwnedQuantity() {
    _ownedQuantityFuture = _fetchOwnedQuantity().then((value) {
      if (mounted) {
        setState(() => _cachedOwnedQuantity = value);
      }
      return value;
    });
  }

  Future<int> _fetchOwnedQuantity() async {
    final slots = await di.getIt<CollectionRepository>().getSlotsForCard(
          widget.entry.card.id,
          widget.entry.setCode,
          widget.entry.setRarity,
        );
    return slots.fold<int>(0, (sum, s) => sum + s.quantity);
  }

  @override
  Widget build(BuildContext context) {
    final key = widget.entry.selectionKey;

    return BlocListener<CollectionCubit, CollectionState>(
      listenWhen: (previous, current) {
        final prevLoaded = previous.maybeWhen(
          loaded: (entries, _, __, ___, ____) => entries,
          orElse: () => null,
        );
        final currLoaded = current.maybeWhen(
          loaded: (entries, _, __, ___, ____) => entries,
          orElse: () => null,
        );
        if (currLoaded != null) {
          if (prevLoaded == null) return true;
          return prevLoaded.length != currLoaded.length;
        }
        return false;
      },
      listener: (context, state) => _loadOwnedQuantity(),
      child: BlocListener<QuickAddCubit, QuickAddState>(
        listenWhen: (previous, current) =>
            previous.hasItems && !current.hasItems,
        listener: (context, state) => _loadOwnedQuantity(),
        child: BlocSelector<QuickAddCubit, QuickAddState, int>(
          selector: (state) => state.quantityFor(key),
          builder: (context, cartQty) => _buildTile(context, cartQty: cartQty),
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, {required int cartQty}) {
    final theme = Theme.of(context);
    final key = widget.entry.selectionKey;
    final inCart = cartQty > 0;
    final rarityShort = Rarity.getShortRarity(widget.entry.setRarity);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.md,
        vertical: 3,
      ),
      child: Material(
        color: inCart
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Dimensions.radiusMd),
        clipBehavior: Clip.antiAlias,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusMd),
            border: Border.all(
              color: inCart
                  ? theme.colorScheme.primary.withValues(alpha: 0.4)
                  : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.sm + 4,
            ),
            child: Row(
              children: [
                // Set info column
                Expanded(
                  child: Row(
                    children: [
                      // Set code
                      Text(
                        widget.entry.setCode,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(width: Dimensions.sm),
                      // Rarity chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer
                              .withValues(alpha: 0.7),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSm),
                        ),
                        child: Text(
                          rarityShort,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSecondaryContainer,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      // Owned badge
                      _OwnedBadge(
                        future: _ownedQuantityFuture,
                        cached: _cachedOwnedQuantity,
                      ),
                    ],
                  ),
                ),
                // Quantity stepper
                QuantityStepper(
                  value: cartQty,
                  min: 0,
                  onDecrease: () {
                    final cubit = context.read<QuickAddCubit>();
                    if (cartQty > 1) {
                      cubit.setQuantity(widget.entry, cartQty - 1);
                    } else {
                      cubit.removeItem(key);
                    }
                  },
                  onIncrease: () {
                    context
                        .read<QuickAddCubit>()
                        .setQuantity(widget.entry, cartQty + 1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OwnedBadge extends StatelessWidget {
  final Future<int>? future;
  final int? cached;

  const _OwnedBadge({required this.future, required this.cached});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<int>(
      future: future,
      builder: (context, snapshot) {
        final owned = snapshot.data ?? cached ?? 0;
        if (owned <= 0) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(left: Dimensions.sm),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(Dimensions.radiusSm),
            ),
            child: Text(
              'Owned: $owned',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        );
      },
    );
  }
}
