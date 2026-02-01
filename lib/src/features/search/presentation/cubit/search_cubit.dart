import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchState.initial());

  Future<void> searchCards(String query) async {
    try {
      emit(const SearchState.loading());
      final cards = await _searchRepository.searchCards(query);
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
