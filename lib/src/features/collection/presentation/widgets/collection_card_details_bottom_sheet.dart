import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/di/injection_container.dart' as di;
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

/// Bottom sheet that displays all versions/rarities of a card in the collection
class CollectionCardDetailsBottomSheet extends StatefulWidget {
  final YgoCard card;

  const CollectionCardDetailsBottomSheet({
    super.key,
    required this.card,
  });

  @override
  State<CollectionCardDetailsBottomSheet> createState() =>
      _CollectionCardDetailsBottomSheetState();
}

class _CollectionCardDetailsBottomSheetState
    extends State<CollectionCardDetailsBottomSheet> {
  final Map<String, int> _quantities = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCollectionData();
  }

  Future<void> _loadCollectionData() async {
    final cubit = di.getIt<CollectionCubit>();
    final existingItems =
        await cubit.getCollectionItemsByCardId(widget.card.id);

    if (mounted) {
      setState(() {
        for (final item in existingItems) {
          final key = '${item.setCode}_${item.setRarity}';
          _quantities[key] = item.quantity;
        }
        _isLoading = false;
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

    // Fetch existing items once before the loop
    final existingItems =
        await cubit.getCollectionItemsByCardId(widget.card.id);

    for (final set in widget.card.cardSets) {
      final key = '${set.setCode}_${set.setRarity}';
      final quantity = _quantities[key] ?? 0;

      // Check if this specific set/rarity combination already exists
      final existingItem = existingItems.firstWhere(
        (item) =>
            item.setCode == set.setCode && item.setRarity == set.setRarity,
        orElse: () => CollectionItemEntity(
          cardId: -1,
          cardName: '',
          setCode: '',
          setRarity: '',
          quantity: 0,
          dateAdded: now,
        ),
      );

      if (quantity > 0) {
        if (existingItem.cardId != -1) {
          // Item exists, update quantity (replace, not add)
          await cubit.updateQuantity(
            widget.card.id,
            set.setCode,
            set.setRarity,
            quantity,
          );
        } else {
          // Item doesn't exist, add it
          final item = CollectionItemEntity(
            cardId: widget.card.id,
            cardName: widget.card.name,
            setCode: set.setCode,
            setRarity: set.setRarity,
            quantity: quantity,
            dateAdded: now,
          );
          await cubit.addCollectionItem(item);
        }
      } else {
        // If quantity is 0, remove the item (only if it exists)
        if (existingItem.cardId != -1) {
          await cubit.deleteCollectionItem(
            widget.card.id,
            set.setCode,
            set.setRarity,
          );
        }
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
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(Dimensions.xl),
              child: Center(child: CircularProgressIndicator()),
            )
          else
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
              onPressed: _isLoading ? null : _save,
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
