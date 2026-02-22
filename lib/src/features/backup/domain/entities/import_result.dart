import 'package:freezed_annotation/freezed_annotation.dart';

part 'import_result.freezed.dart';

@freezed
abstract class ImportResult with _$ImportResult {
  const factory ImportResult({
    required int boxesImported,
    required int itemsImported,
    required int cardsCached,
  }) = _ImportResult;
}
