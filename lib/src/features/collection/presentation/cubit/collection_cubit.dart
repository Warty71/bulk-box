import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/card_repository.dart';
import 'collection_state.dart';
import '../../data/datasources/local/image_local_datasource.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final CardRepository _cardRepository;

  CollectionCubit(this._cardRepository)
      : super(const CollectionState.initial());

  Future<void> searchCards(String query) async {
    try {
      emit(const CollectionState.loading());
      final cards = await _cardRepository.searchCards(query);
      emit(CollectionState.loaded(cards: cards, hasReachedMax: true));
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  Future<void> loadCardImage(int cardId) async {
    try {
      if (!await _cardRepository.isCardImageSaved(cardId)) {}
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }

  Future<String> getCardImagePath(int cardId) async {
    try {
      return await _cardRepository.getLocalImagePath(cardId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearImageCache() async {
    try {
      final imageLocalDatasource = ImageLocalDatasource();
      await imageLocalDatasource.clearImageCache();

      state.when(
        initial: () => null,
        loading: () => null,
        error: (_) => null,
        loaded: (cards, hasReachedMax) {
          emit(const CollectionState.loading());
          emit(CollectionState.loaded(cards: cards, hasReachedMax: true));
        },
      );
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }
}
