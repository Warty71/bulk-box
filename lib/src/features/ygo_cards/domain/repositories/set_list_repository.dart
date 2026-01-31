import 'package:bulk_box/src/features/ygo_cards/data/models/set_info_model.dart';

abstract class SetListRepository {
  Future<List<SetInfoModel>> getLatestSets({int limit = 10});
}
