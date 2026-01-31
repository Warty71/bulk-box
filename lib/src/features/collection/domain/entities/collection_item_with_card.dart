import 'package:ygo_collector/src/features/collection/domain/entities/collection_item.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

class CollectionItemWithCard {
  final CollectionItemEntity item;
  final YgoCard card;

  CollectionItemWithCard({required this.item, required this.card});
}
