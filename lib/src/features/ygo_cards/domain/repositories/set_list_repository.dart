import 'package:bulk_box/src/features/ygo_cards/domain/entities/set_info.dart';

abstract class SetListRepository {
  Future<List<SetInfo>> getLatestSets({int limit = 10});
}
