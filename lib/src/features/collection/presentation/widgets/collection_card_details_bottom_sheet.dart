import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/database/app_database.dart' as db;
import 'package:ygo_collector/src/core/database/card_extensions.dart';
import 'package:ygo_collector/src/core/di/injection_container.dart' as di;
import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';

/// Bottom sheet that displays all versions/rarities of a card in the collection.
/// Used when tapping a card in the collection grid.
class CollectionCardDetailsBottomSheet extends StatefulWidget {
  final db.Card card;

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

    final existingItems =
        await cubit.getCollectionItemsByCardId(widget.card.id);

    for (final set in widget.card.parsedCardSets) {
      final key = '${set.setCode}_${set.setRarity}';
      final quantity = _quantities[key] ?? 0;

      final existingItem = existingItems.firstWhere(
        (item) =>
            item.setCode == set.setCode && item.setRarity == set.setRarity,
        orElse: () => CollectionItemEntity(
          cardId: -1,
          setCode: '',
          setRarity: '',
          quantity: 0,
          dateAdded: now,
        ),
      );

      if (quantity > 0) {
        if (existingItem.cardId != -1) {
          await cubit.updateQuantity(
            widget.card.id,
            set.setCode,
            set.setRarity,
            quantity,
          );
        } else {
          final item = CollectionItemEntity(
            cardId: widget.card.id,
            setCode: set.setCode,
            setRarity: set.setRarity,
            quantity: quantity,
            dateAdded: now,
          );
          await cubit.addCollectionItem(item);
        }
      } else {
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
    final cardSets = widget.card.parsedCardSets;

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
          else if (cardSets.isEmpty)
            const Padding(
              padding: EdgeInsets.all(Dimensions.xl),
              child: Center(child: Text('No sets available for this card')),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cardSets.length,
                itemBuilder: (context, index) {
                  final set = cardSets[index];
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
