import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:bulk_box/src/features/settings/presentation/cubit/settings_state.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setSortOption(SortOption option) {
    if (state.sortOption == option) return;
    emit(state.copyWith(sortOption: option));
  }

  void setShowDividers(bool value) {
    if (state.showDividers == value) return;
    emit(state.copyWith(showDividers: value));
  }

  void setBoxExclusiveSorting(bool value) {
    if (state.boxExclusiveSorting == value) return;
    emit(state.copyWith(boxExclusiveSorting: value));
  }

  void setBoxSortOption(String boxKey, SortOption option) {
    final current = state.boxSortOptions[boxKey];
    if (current == option) return;
    emit(state.copyWith(
      boxSortOptions: {...state.boxSortOptions, boxKey: option},
    ));
  }

  SortOption effectiveSortOption(String? boxKey) {
    if (state.boxExclusiveSorting && boxKey != null) {
      return state.boxSortOptions[boxKey] ?? state.sortOption;
    }
    return state.sortOption;
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(SettingsState state) => state.toJson();
}
