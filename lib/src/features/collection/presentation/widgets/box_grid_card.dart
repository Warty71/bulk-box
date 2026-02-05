import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/utils/color_utils.dart';
import 'package:bulk_box/src/core/widgets/tappable_info_card.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box_or_unboxed.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';

/// Grid card for a box or Unboxed. Uses [TappableInfoCard]; for boxes loads count via [BoxesCubit].
class BoxGridCard extends StatelessWidget {
  final BoxOrUnboxed item;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const BoxGridCard({
    super.key,
    required this.item,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (item.isUnboxed) {
      return TappableInfoCard(
        icon: Icons.inbox_outlined,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        title: 'Unboxed',
        subtitle: 'Items not in any box',
        onTap: onTap,
        onDelete: null,
      );
    }

    return _BoxGridCardWithCount(
      box: item.box!,
      onTap: onTap,
      onDelete: onDelete,
    );
  }
}

class _BoxGridCardWithCount extends StatelessWidget {
  final Box box;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _BoxGridCardWithCount({
    required this.box,
    required this.onTap,
    this.onDelete,
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
        return TappableInfoCard(
          icon: Icons.inventory_2_outlined,
          backgroundColor: backgroundColor,
          title: box.name,
          subtitle: '$count item${count == 1 ? '' : 's'}',
          onTap: onTap,
          onDelete: onDelete,
        );
      },
    );
  }
}
