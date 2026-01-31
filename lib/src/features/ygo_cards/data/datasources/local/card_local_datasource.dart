import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/models/card_model.dart';

class CardLocalDatasource {
  final SharedPreferences _prefs;
  static const String _cardsKey = 'cached_cards';

  CardLocalDatasource(this._prefs);

  /// Save cards in cache
  Future<void> cacheCards(List<CardModel> newCards) async {
    final existing = await getCachedCards();

    final Map<int, CardModel> cardMap = {
      for (final card in existing) card.id: card,
    };

    for (final card in newCards) {
      cardMap[card.id] = card;
    }

    final merged = cardMap.values.map((c) => c.toJson()).toList();
    await _prefs.setString(_cardsKey, jsonEncode(merged));
  }

  /// Safely get a card by ID, returns null if not found
  Future<YgoCard?> getCardById(int cardId) async {
    final cards = await getCachedCards();

    final cardModel = cards.cast<CardModel?>().firstWhere(
          (c) => c!.id == cardId,
          orElse: () => null,
        );

    if (cardModel == null) return null;

    // Convert CardModel -> YgoCard
    return YgoCard(
      id: cardModel.id,
      name: cardModel.name,
      type: cardModel.type,
      description: cardModel.desc,
      race: cardModel.race,
      attribute: cardModel.attribute,
      level: cardModel.level,
      atk: cardModel.atk,
      def: cardModel.def,
      imageUrl: cardModel.cardImages.isNotEmpty
          ? cardModel.cardImages.first.imageUrl
          : '',
      cardSets: cardModel.cardSets
          .map((cs) => CardSet(
                setName: cs.setName,
                setCode: cs.setCode,
                setRarity: cs.setRarity,
              ))
          .toList(),
    );
  }

  /// Get all cached cards
  Future<List<CardModel>> getCachedCards() async {
    final cardsJson = _prefs.getString(_cardsKey);
    if (cardsJson == null) return [];

    final List<dynamic> decoded = jsonDecode(cardsJson);
    return decoded.map((json) => CardModel.fromJson(json)).toList();
  }

  /// Clear cache
  Future<void> clearCache() async {
    await _prefs.remove(_cardsKey);
  }
}
