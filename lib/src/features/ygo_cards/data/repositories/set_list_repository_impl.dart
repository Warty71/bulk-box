import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/models/set_info_model.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/repositories/set_list_repository.dart';

class SetListRepositoryImpl implements SetListRepository {
  final YGOProApiDatasource _apiDatasource;

  SetListRepositoryImpl(this._apiDatasource);

  @override
  Future<List<SetInfoModel>> getLatestSets({int limit = 10}) async {
    try {
      final raw = await _apiDatasource.getCardSets();
      final parsed = <SetInfoModel>[];
      for (final item in raw) {
        try {
          parsed.add(SetInfoModel.fromJson(item));
        } catch (_) {
          // Skip malformed entries
        }
      }
      // Deduplicate by set_code: keep entry with latest tcg_date per set_code
      final byCode = <String, SetInfoModel>{};
      for (final s in parsed) {
        final existing = byCode[s.setCode];
        if (existing == null || s.tcgDate.compareTo(existing.tcgDate) > 0) {
          byCode[s.setCode] = s;
        }
      }
      final deduped = byCode.values.toList();
      deduped.sort((a, b) => b.tcgDate.compareTo(a.tcgDate));
      return deduped.take(limit).toList();
    } catch (e) {
      rethrow;
    }
  }
}
