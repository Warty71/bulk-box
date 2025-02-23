import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/models/card_model.dart';

class CardLocalDatasource {
  final SharedPreferences _prefs;
  static const String _cardsKey = 'cached_cards';

  CardLocalDatasource(this._prefs);

  Future<void> cacheCards(List<CardModel> cards) async {
    final cardsJson = cards.map((card) => card.toJson()).toList();
    await _prefs.setString(_cardsKey, jsonEncode(cardsJson));
  }

  Future<List<CardModel>> getCachedCards() async {
    final cardsJson = _prefs.getString(_cardsKey);
    if (cardsJson == null) return [];

    final List<dynamic> decoded = jsonDecode(cardsJson);
    return decoded.map((json) => CardModel.fromJson(json)).toList();
  }

  Future<void> clearCache() async {
    await _prefs.remove(_cardsKey);
  }
}
