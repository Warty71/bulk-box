import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/database/app_database.dart';
import 'package:ygo_collector/src/core/database/card_extensions.dart';
import 'package:ygo_collector/src/features/search/domain/repositories/search_repository.dart';
import 'package:ygo_collector/src/features/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchState.initial());

  static void _debugPrintCards(List<Card> cards) {
    if (cards.isEmpty) {
      debugPrint('  (no cards)');
      return;
    }
    const descWrapWidth = 65;
    String wrapDesc(String text) {
      if (text.length <= descWrapWidth) return text;
      final buf = StringBuffer();
      var start = 0;
      while (start < text.length) {
        final end = start + descWrapWidth;
        if (end >= text.length) {
          buf.writeln(text.substring(start));
          break;
        }
        var breakAt = text.lastIndexOf(' ', end);
        if (breakAt <= start) breakAt = end;
        buf.writeln(text.substring(start, breakAt).trim());
        start = breakAt;
      }
      return buf.toString().trim();
    }

    for (var i = 0; i < cards.length; i++) {
      final card = cards[i];
      final descLines = wrapDesc(card.description).split('\n');
      debugPrint('');
      debugPrint(
          '  ┌─ Card ${i + 1}/${cards.length} ─────────────────────────');
      debugPrint('  │ id:        ${card.id}');
      debugPrint('  │ name:      ${card.name}');
      debugPrint('  │ type:      ${card.type}');
      debugPrint('  │ race:      ${card.race}');
      if (card.attribute != null)
        debugPrint('  │ attribute: ${card.attribute}');
      if (card.level != null) debugPrint('  │ level:     ${card.level}');
      if (card.atk != null) debugPrint('  │ atk:       ${card.atk}');
      if (card.def != null) debugPrint('  │ def:       ${card.def}');
      debugPrint('  │ desc:      ${descLines.first}');
      for (var j = 1; j < descLines.length; j++) {
        debugPrint('  │            ${descLines[j]}');
      }
      final sets = card.parsedCardSets;
      if (sets.isEmpty) {
        debugPrint('  │ sets:      (none)');
      } else {
        debugPrint('  │ sets:      ${sets.length} version(s)');
        for (final s in sets) {
          debugPrint('  │   • ${s.setName} (${s.setCode}) - ${s.setRarity}');
        }
      }
      debugPrint('  └──────────────────────────────────────────────');
    }
    debugPrint('');
  }

  Future<void> searchCards(String query) async {
    try {
      emit(const SearchState.loading());
      final cards = await _searchRepository.searchCards(query);
      _debugPrintCards(cards);
      emit(SearchState.loaded(cards: cards, lastQuery: query));
    } catch (e) {
      emit(SearchState.error(e.toString()));
    }
  }

  Future<String> getCardImagePath(int cardId) async {
    try {
      return await _searchRepository.getCardImagePath(cardId);
    } catch (e) {
      rethrow;
    }
  }
}
