import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/enums/rarity.dart';
import 'package:bulk_box/src/core/utils/set_code_utils.dart';
import 'package:bulk_box/src/core/widgets/quantity_stepper.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';

/// Compact list tile for a search result entry (set/rarity variant).
/// Shows card name, set code, rarity, owned quantity, and quantity stepper.
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
    // Reload if the entry changed (different card/set/rarity)
    if (oldWidget.entry.selectionKey != widget.entry.selectionKey) {
      _loadOwnedQuantity();
    }
  }

  void _loadOwnedQuantity() {
    _ownedQuantityFuture = _fetchOwnedQuantity().then((value) {
      if (mounted) {
        setState(() {
          _cachedOwnedQuantity = value;
        });
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
    final theme = Theme.of(context);
    final key = widget.entry.selectionKey;

    return BlocListener<CollectionCubit, CollectionState>(
      listenWhen: (previous, current) {
        // Reload owned quantity when collection state changes
        // CollectionCubit reloads (loading -> loaded) after every operation
        // Compare states to detect when collection was updated
        final prevLoaded = previous.maybeWhen(
          loaded: (entries, _, __, ___, ____) => entries,
          orElse: () => null,
        );
        final currLoaded = current.maybeWhen(
          loaded: (entries, _, __, ___, ____) => entries,
          orElse: () => null,
        );
        // Reload if we transitioned to loaded state (operation completed)
        // or if entries changed (different length indicates add/remove)
        if (currLoaded != null) {
          if (prevLoaded == null) {
            // Transitioned to loaded from non-loaded state
            return true;
          }
          // Entries list changed (items added/removed)
          return prevLoaded.length != currLoaded.length;
        }
        return false;
      },
      listener: (context, state) {
        // Collection was updated, reload owned quantity
        _loadOwnedQuantity();
      },
      child: BlocListener<QuickAddCubit, QuickAddState>(
        listenWhen: (previous, current) {
          // Reload owned quantity when cart is cleared (after items are added)
          // Check if cart went from having items to being empty
          return previous.hasItems && !current.hasItems;
        },
        listener: (context, state) {
          // Cart was cleared after adding items, reload owned quantity
          _loadOwnedQuantity();
        },
        child: BlocSelector<QuickAddCubit, QuickAddState, (int, bool)>(
        selector: (state) => (
          state.quantityFor(key),
          state.isSelected(key),
        ),
        builder: (context, data) {
          final cartQty = data.$1;
          final isSelected = data.$2;
          final inCart = cartQty > 0;

        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.md,
            vertical: Dimensions.xs,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primaryContainer.withValues(alpha: 0.5)
                : inCart
                    ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
                    : null,
            borderRadius: BorderRadius.circular(Dimensions.radiusSm),
            border: isSelected
                ? Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  )
                : inCart
                    ? Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                        width: 1,
                      )
                    : null,
          ),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Dimensions.sm,
              vertical: Dimensions.xs,
            ),
            onTap: () {
              HapticFeedback.selectionClick();
              context.read<QuickAddCubit>().selectEntry(widget.entry);
            },
            title: Text(
              widget.entry.card.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(
              children: [
                // Set code badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    shortSetCode(widget.entry.setCode),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.xs),
                // Rarity badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    Rarity.getShortRarity(widget.entry.setRarity),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Owned quantity badge (if > 0)
                FutureBuilder<int>(
                  future: _ownedQuantityFuture,
                  builder: (context, snapshot) {
                    final owned = snapshot.data ?? _cachedOwnedQuantity ?? 0;
                    if (owned <= 0) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(left: Dimensions.xs),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'x$owned',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            trailing: QuantityStepper(
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
                context.read<QuickAddCubit>().setQuantity(widget.entry, cartQty + 1);
              },
            ),
          ),
        );
        },
      ),
      ),
    );
  }
}
