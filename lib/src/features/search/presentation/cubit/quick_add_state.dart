import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

part 'quick_add_state.freezed.dart';

@freezed
abstract class QuickAddItem with _$QuickAddItem {
  const factory QuickAddItem({
    required YgoCard card,
    required String setCode,
    required String setRarity,
    required int quantity,
  }) = _QuickAddItem;
}

@freezed
abstract class QuickAddState with _$QuickAddState {
  const QuickAddState._();

  const factory QuickAddState({
    @Default(<String, QuickAddItem>{}) Map<String, QuickAddItem> cart,
  }) = _QuickAddState;

  int get totalCount =>
      cart.values.fold(0, (sum, item) => sum + item.quantity);

  bool get hasItems => cart.isNotEmpty;

  int quantityFor(String selectionKey) =>
      cart[selectionKey]?.quantity ?? 0;
}
