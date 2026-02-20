import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/search/domain/entities/card_search_filters.dart';
import 'package:bulk_box/src/features/search/domain/entities/search_result_entry.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_state.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/entities/ygo_card.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchState.initial());

  /// Always fetches fresh results from the API.
  Future<void> searchCards(String query, {CardSearchFilters? filters}) async {
    final hasFilters = filters != null && !filters.isEmpty;
    if (query.isEmpty && !hasFilters) {
      emit(const SearchState.initial());
      return;
    }

    try {
      emit(const SearchState.loading());

      final apiCards =
          await _searchRepository.searchCards(query, filters: filters);
      final entries = _explodeCards(apiCards, sortByApi: filters?.sortBy != null);
      emit(SearchState.loaded(
        entries: entries,
        grouped: _groupByCardName(entries),
        lastQuery: query,
        lastFilters: filters,
      ));
    } catch (e) {
      emit(SearchState.error(e.toString()));
    }
  }

  Future<void> updateFilters(CardSearchFilters filters) async {
    final currentQuery = state.maybeWhen(
      loaded: (_, __, lastQuery, ____) => lastQuery,
      orElse: () => '',
    );
    await searchCards(currentQuery, filters: filters);
  }

  /// Explode each card's cardSets into individual SearchResultEntry objects.
  List<SearchResultEntry> _explodeCards(
    List<YgoCard> cards, {
    bool sortByApi = false,
  }) {
    final entries = <SearchResultEntry>[];
    for (final card in cards) {
      if (card.cardSets.isEmpty) {
        entries.add(SearchResultEntry(
          card: card,
          setName: 'Unknown',
          setCode: 'N/A',
          setRarity: 'N/A',
        ));
      } else {
        for (final s in card.cardSets) {
          entries.add(SearchResultEntry(
            card: card,
            setName: s.setName,
            setCode: s.setCode,
            setRarity: s.setRarity,
          ));
        }
      }
    }
    if (!sortByApi) {
      entries.sort((a, b) {
        final nameCompare = a.card.name.compareTo(b.card.name);
        if (nameCompare != 0) return nameCompare;
        return a.setCode.compareTo(b.setCode);
      });
    }
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
