import 'dart:convert';

import 'package:ygo_collector/src/core/database/app_database.dart';

/// Parsed card set from [Card.cardSetsJson].
class ParsedCardSet {
  final String setName;
  final String setCode;
  final String setRarity;

  ParsedCardSet({
    required this.setName,
    required this.setCode,
    required this.setRarity,
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
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }
}
