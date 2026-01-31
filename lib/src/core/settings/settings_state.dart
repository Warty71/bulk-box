import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SortOption.nameAZ) SortOption sortOption,
    @Default(false) bool showDividers,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
