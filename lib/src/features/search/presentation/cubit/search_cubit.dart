import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/core/database/card_extensions.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchState.initial());

  /// Local-first search: queries local DB first, falls back to API if no results.
  Future<void> searchCards(String query) async {
    if (query.isEmpty) {
      emit(const SearchState.initial());
      return;
    }

    try {
      emit(const SearchState.loading());

      // Try local first
      final localCards = await _searchRepository.searchCardsLocal(query);
      if (localCards.isNotEmpty) {
        final entries = _explodeCards(localCards);
        emit(SearchState.loaded(
          entries: entries,
          grouped: _groupByCardName(entries),
          lastQuery: query,
        ));
        return;
      }

      // No local results — fetch from API
      final apiCards = await _searchRepository.searchCards(query);
      final entries = _explodeCards(apiCards);
      emit(SearchState.loaded(
        entries: entries,
        grouped: _groupByCardName(entries),
        lastQuery: query,
      ));
    } catch (e) {
      emit(SearchState.error(e.toString()));
    }
  }

  /// Explode each card's parsedCardSets into individual SearchResultEntry objects.
  List<SearchResultEntry> _explodeCards(List<Card> cards) {
    final entries = <SearchResultEntry>[];
    for (final card in cards) {
      final sets = card.parsedCardSets;
      if (sets.isEmpty) {
        entries.add(SearchResultEntry(
          card: card,
          setName: 'Unknown',
          setCode: 'N/A',
          setRarity: 'N/A',
        ));
      } else {
        for (final s in sets) {
          entries.add(SearchResultEntry(
            card: card,
            setName: s.setName,
            setCode: s.setCode,
            setRarity: s.setRarity,
          ));
        }
      }
    }
    entries.sort((a, b) {
      final nameCompare = a.card.name.compareTo(b.card.name);
      if (nameCompare != 0) return nameCompare;
      return a.setCode.compareTo(b.setCode);
    });
    return entries;
  }

  /// Group entries by card name for the sectioned grid.
  Map<String, List<SearchResultEntry>> _groupByCardName(
    List<SearchResultEntry> entries,
  ) {
    final grouped = <String, List<SearchResultEntry>>{};
    for (final entry in entries) {
      grouped.putIfAbsent(entry.card.name, () => []).add(entry);
    }
    return grouped;
  }
}
