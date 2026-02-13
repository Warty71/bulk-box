import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/enums/rarity.dart';
import 'package:bulk_box/src/core/utils/set_code_utils.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';

/// Bottom sheet listing all cart items.
/// Only shows if cart has items. Displays items without quantity controls.
class QuickAddCartSheet extends StatelessWidget {
  /// Called when user taps "Add to Collection". Pops the sheet first,
  /// then the parent should show the destination picker.
  final VoidCallback onAddPressed;

  const QuickAddCartSheet({super.key, required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<QuickAddCubit, QuickAddState>(
      listenWhen: (previous, current) => !current.hasItems && previous.hasItems,
      listener: (context, state) {
        // Auto-close if cart becomes empty
        Navigator.of(context).pop();
      },
      child: BlocBuilder<QuickAddCubit, QuickAddState>(
        builder: (context, state) {
          // Don't show if cart is empty
          if (!state.hasItems) {
            return const SizedBox.shrink();
          }

          final items = state.cart.entries.toList();
          final totalCount = state.totalCount;

          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(Dimensions.md),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 28,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: Dimensions.sm),
                      Expanded(
                        child: Text(
                          'Cart ($totalCount card${totalCount == 1 ? '' : 's'})',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Cart items
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final entry = items[index];
                      final item = entry.value;

                      return ListTile(
                        title: Text(
                          item.card.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${shortSetCode(item.setCode)} - ${Rarity.getShortRarity(item.setRarity)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.outline,
                          ),
                        ),
                        trailing: Text(
                          'x${item.quantity}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom actions
                Padding(
                  padding: const EdgeInsets.all(Dimensions.md),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<QuickAddCubit>().clearCart();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Deselect All'),
                        ),
                      ),
                      const SizedBox(width: Dimensions.sm),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onAddPressed();
                          },
                          child: const Text('Add'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
