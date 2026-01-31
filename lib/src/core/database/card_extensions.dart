import 'dart:convert';

import 'package:bulk_box/src/core/database/app_database.dart';

/// Parsed card set from [Card.cardSetsJson].
/// When [tcgplayer_data] is used, includes edition, prices, and TCGPlayer URL.
class ParsedCardSet {
  final String setName;
  final String setCode;
  final String setRarity;
  final String? setEdition;
  final String? setPrice;
  final String? setPriceLow;
  final String? setUrl;

  ParsedCardSet({
    required this.setName,
    required this.setCode,
    required this.setRarity,
    this.setEdition,
    this.setPrice,
    this.setPriceLow,
    this.setUrl,
  });
}

extension CardX on Card {
  /// Parses [cardSetsJson] into a list of [ParsedCardSet].
  List<ParsedCardSet> get parsedCardSets {
    try {
      final list = jsonDecode(cardSetsJson) as List;
      return list.map((e) {
        final m = e as Map<String, dynamic>;
        return ParsedCardSet(
          setName: m['set_name'] as String? ?? '',
          setCode: m['set_code'] as String? ?? '',
          setRarity: m['set_rarity'] as String? ?? '',
          setEdition: m['set_edition'] as String?,
          setPrice: m['set_price'] as String?,
          setPriceLow: m['set_price_low'] as String?,
          setUrl: m['set_url'] as String?,
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }
}
