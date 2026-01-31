import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/features/ygo_cards/domain/repositories/set_list_repository.dart';
import 'package:ygo_collector/src/features/home/presentation/cubit/latest_sets_state.dart';

class LatestSetsCubit extends Cubit<LatestSetsState> {
  final SetListRepository _setListRepository;

  LatestSetsCubit(this._setListRepository) : super(const LatestSetsState.initial()) {
    load();
  }

  Future<void> load({int limit = 10}) async {
    try {
      emit(const LatestSetsState.loading());
      final sets = await _setListRepository.getLatestSets(limit: limit);
      emit(LatestSetsState.loaded(sets));
    } catch (e) {
      emit(LatestSetsState.failure(e.toString()));
    }
  }
}
