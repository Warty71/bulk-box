import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/domain/entities/collection_item.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/ygo_cards/data/mappers/card_model_mapper.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/card_set.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

/// Bottom sheet for adding/editing card quantities in collection.
/// Works for both adding new cards and editing existing ones.
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
  bool _isLoading = true;
  bool _isSaving = false;

  /// Use API sets when present; otherwise one synthetic set so the user can still add the card.
  List<CardSet> get _effectiveCardSets {
    final p = widget.card.cardSets;
    if (p.isEmpty) {
      return [
        const CardSet(
          setName: 'Unknown',
          setCode: 'N/A',
          setRarity: 'N/A',
        ),
      ];
    }
    return p;
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    for (final set in _effectiveCardSets) {
      final key = '${set.setCode}_${set.setRarity}';
      _quantities[key] = 0;
    }

    final cubit = di.getIt<CollectionCubit>();
    final existingItems =
        await cubit.getCollectionItemsByCardId(widget.card.id);

    if (mounted) {
      setState(() {
        for (final item in existingItems) {
          final key = '${item.setCode}_${item.setRarity}';
          _quantities[key] = (_quantities[key] ?? 0) + item.quantity;
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
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      // Ensure card is in DB (e.g. when opened from search, insert may not have completed).
      await di
          .getIt<CardDao>()
          .insertOrUpdateCards([CardModelMapper.toDriftCard(widget.card)]);

      final cubit = di.getIt<CollectionCubit>();
      final now = DateTime.now();

      for (final set in _effectiveCardSets) {
        final key = '${set.setCode}_${set.setRarity}';
        final newTotal = _quantities[key] ?? 0;
        final slots = await cubit.getSlotsForCard(
          widget.card.id,
          set.setCode,
          set.setRarity,
        );
        final oldTotal = slots.fold<int>(0, (sum, s) => sum + s.quantity);
        final delta = newTotal - oldTotal;

        if (delta > 0) {
          for (var i = 0; i < delta; i++) {
            await cubit.addCollectionItem(
              CollectionItemEntity(
                cardId: widget.card.id,
                setCode: set.setCode,
                setRarity: set.setRarity,
                quantity: 1,
                dateAdded: now,
                boxId: null,
              ),
            );
          }
        } else if (delta < 0) {
          final selectedSlot = slots.isEmpty
              ? null
              : (slots.where((s) => s.boxId == null).firstOrNull ??
                  slots.first);
          if (selectedSlot != null) {
            var remove = -delta;
            var q = selectedSlot.quantity;
            while (remove > 0 && q > 0) {
              q--;
              remove--;
              await cubit.updateSlotQuantity(
                widget.card.id,
                set.setCode,
                set.setRarity,
                selectedSlot.boxId,
                q,
              );
            }
          }
        }
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardSets = _effectiveCardSets;

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
              onPressed: (_isLoading || _isSaving) ? null : _save,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
