import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/utils/color_utils.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/box_card_tile.dart';

/// Grid card for a named box: loads count and shows [BoxCardTile].
class BoxGridCardWithCount extends StatelessWidget {
  final Box box;
  final VoidCallback onTap;
  final Widget? trailing;

  const BoxGridCardWithCount({
    super.key,
    required this.box,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: context.read<BoxesCubit>().countItemsInBox(box.id),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        final backgroundColor = box.color != null
            ? parseHexColor(box.color!)
            : Theme.of(context).colorScheme.primaryContainer;
        return BoxCardTile(
          icon: Icons.inventory_2_outlined,
          backgroundColor: backgroundColor,
          title: box.name,
          subtitle: '$count card${count == 1 ? '' : 's'}',
          onTap: onTap,
          trailing: trailing,
        );
      },
    );
  }
}
