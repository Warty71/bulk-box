import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sort_state.dart';
import 'package:ygo_collector/src/features/sorting/domain/entities/sort_options.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit() : super(SortState.initial());

  void setSort(SortOption option) {
    if (state.option == option) return;
    debugPrint('setting sort to: $option');
    emit(state.copyWith(option: option));
  }
}
