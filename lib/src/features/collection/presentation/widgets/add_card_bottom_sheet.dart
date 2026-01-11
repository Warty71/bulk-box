import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/di/injection_container.dart' as di;
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

class AddCardBottomSheet extends StatefulWidget {
  final YgoCard card;

  const AddCardBottomSheet({
    super.key,
    required this.card,
  });

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final Map<String, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    // Initialize quantities to 0 for all card sets
    for (final set in widget.card.cardSets) {
      final key = '${set.setCode}_${set.setRarity}';
      _quantities[key] = 0;
    }
    // Load existing quantities
    _loadExistingQuantities();
  }

  Future<void> _loadExistingQuantities() async {
    final cubit = di.getIt<CollectionCubit>();
    final existingItems =
        await cubit.getCollectionItemsByCardId(widget.card.id);

    if (mounted) {
      setState(() {
        for (final item in existingItems) {
          final key = '${item.setCode}_${item.setRarity}';
          _quantities[key] = item.quantity;
        }
      });
    }
  }

  void _updateQuantity(String setCode, String setRarity, int delta) {
    setState(() {
      final key = '${setCode}_$setRarity';
      final current = _quantities[key] ?? 0;
      _quantities[key] = (current + delta).clamp(0, 999);
    });
  }

  Future<void> _save() async {
    final cubit = di.getIt<CollectionCubit>();
    final now = DateTime.now();

    for (final set in widget.card.cardSets) {
      final key = '${set.setCode}_${set.setRarity}';
      final quantity = _quantities[key] ?? 0;

      if (quantity > 0) {
        final item = CollectionItemEntity(
          cardId: widget.card.id,
          cardName: widget.card.name,
          setCode: set.setCode,
          setRarity: set.setRarity,
          quantity: quantity,
          dateAdded: now,
        );
        await cubit.addCollectionItem(item);
      } else {
        // If quantity is 0, remove the item
        await cubit.deleteCollectionItem(
          widget.card.id,
          set.setCode,
          set.setRarity,
        );
      }
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                Expanded(
                  child: Text(
                    widget.card.name,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(),

          // Card Sets List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.card.cardSets.length,
              itemBuilder: (context, index) {
                final set = widget.card.cardSets[index];
                final key = '${set.setCode}_${set.setRarity}';
                final quantity = _quantities[key] ?? 0;

                return ListTile(
                  title: Text(set.setName),
                  subtitle: Text('${set.setCode} - ${set.setRarity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _updateQuantity(
                          set.setCode,
                          set.setRarity,
                          -1,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          '$quantity',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _updateQuantity(
                          set.setCode,
                          set.setRarity,
                          1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Save Button
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: FilledButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
