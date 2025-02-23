import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/card_repository.dart';
import 'collection_state.dart';

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
      if (!await _cardRepository.isCardImageSaved(cardId)) {
        final imagePath = await _cardRepository.getLocalImagePath(cardId);
      }
    } catch (e) {
      emit(CollectionState.error(e.toString()));
    }
  }
}
