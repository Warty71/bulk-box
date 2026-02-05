import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_state.dart';

class BoxesCubit extends Cubit<BoxesState> {
  final BoxRepository _repository;

  BoxesCubit(this._repository) : super(const BoxesInitial());

  Future<void> loadBoxes() async {
    emit(const BoxesLoading());

    try {
      final boxes = await _repository.getBoxes();
      emit(BoxesLoaded(boxes));
    } catch (e) {
      emit(BoxesError(e.toString()));
    }
  }

  Future<void> createBox({required String name, String? color}) async {
    try {
      await _repository.createBox(name: name, color: color);
      await loadBoxes();
    } catch (e) {
      emit(BoxesError(e.toString()));
    }
  }

  Future<void> updateBox(int id, {String? name, String? color}) async {
    try {
      await _repository.updateBox(id, name: name, color: color);
      await loadBoxes();
    } catch (e) {
      emit(BoxesError(e.toString()));
    }
  }

  Future<void> deleteBox(int id) async {
    try {
      await _repository.deleteBox(id);
      await loadBoxes();
    } catch (e) {
      emit(BoxesError(e.toString()));
    }
  }

  Future<int> countItemsInBox(int id) async {
    try {
      return await _repository.countItemsInBox(id);
    } catch (_) {
      return 0;
    }
  }
}
