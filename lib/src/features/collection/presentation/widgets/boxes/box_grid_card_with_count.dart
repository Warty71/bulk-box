import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/utils/color_utils.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/boxes/box_card_tile.dart';

/// Grid card for a named box: loads count + first 3 entries for preview, shows [BoxCardTile].
class BoxGridCardWithCount extends StatelessWidget {
  final Box box;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const BoxGridCardWithCount({
    super.key,
    required this.box,
    required this.onTap,
    this.onLongPress,
  });

  Future<({int count, List<int> previewCardIds})> _loadData(
      BuildContext context) async {
    final boxesCubit = context.read<BoxesCubit>();
    final collectionRepo = di.getIt<CollectionRepository>();
    final count = await boxesCubit.countItemsInBox(box.id);
    final entries = await collectionRepo.getFirstEntriesInBox(box.id, limit: 3);
    final previewCardIds = entries.map((e) => e.card.id).toList();
    return (count: count, previewCardIds: previewCardIds);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<({int count, List<int> previewCardIds})>(
      future: _loadData(context),
      builder: (context, snapshot) {
        final count = snapshot.data?.count ?? 0;
        final previewCardIds = snapshot.data?.previewCardIds;
        final backgroundColor = box.color != null
            ? parseHexColor(box.color!)
            : Theme.of(context).colorScheme.primaryContainer;
        return BoxCardTile(
          icon: Icons.inventory_2_outlined,
          backgroundColor: backgroundColor,
          title: box.name,
          subtitle: '$count card${count == 1 ? '' : 's'}',
          onTap: onTap,
          onLongPress: onLongPress,
          previewCardIds: previewCardIds,
        );
      },
    );
  }
}
