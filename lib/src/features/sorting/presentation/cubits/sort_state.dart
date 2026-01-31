import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygo_collector/src/features/sorting/domain/entities/sort_options.dart';

part 'sort_state.freezed.dart';

@freezed
abstract class SortState with _$SortState {
  const factory SortState({
    required SortOption option,
  }) = _SortState;

  factory SortState.initial() => const SortState(option: SortOption.nameAZ);
}
