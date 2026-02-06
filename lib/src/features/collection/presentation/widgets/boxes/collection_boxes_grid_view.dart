import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/domain/entities/box_or_unboxed.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/utils/collection_navigation.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/boxes/box_grid_card.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/boxes/boxes_state_view.dart';
import 'package:bulk_box/src/core/widgets/app_dialogs.dart';

/// 2-column grid of boxes (Unboxed + user boxes). No app bar.
/// Tap a box to open cards in that box; FAB to create a new box.
class CollectionBoxesGridView extends StatelessWidget {
  const CollectionBoxesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di.getIt<BoxesCubit>(),
      child: _CollectionBoxesGridBody(),
    );
  }
}

class _CollectionBoxesGridBody extends StatefulWidget {
  @override
  State<_CollectionBoxesGridBody> createState() =>
      _CollectionBoxesGridBodyState();
}

class _CollectionBoxesGridBodyState extends State<_CollectionBoxesGridBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BoxesCubit>().loadBoxes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Boxes'),
            ),
            body: BoxesStateView(
              contentBuilder: (boxes) {
                final items = [
                  BoxOrUnboxed.unboxed(),
                  ...boxes.map((b) => BoxOrUnboxed.box(b)),
                ];
                return GridView.builder(
                  padding: const EdgeInsets.all(Dimensions.md),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimensions.md,
                    crossAxisSpacing: Dimensions.md,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return BoxGridCard(
                      item: item,
                      onTap: () => context.pushCollectionBox(item.box),
                      trailing: item.isUnboxed
                          ? null
                          : _boxMenu(context, item.box!),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => AppDialogs.showCreateBox(context),
              child: const Icon(Icons.add),
            ),
          );
        },
      );
  }

  static Widget _boxMenu(BuildContext context, Box box) {
    final theme = Theme.of(context);
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'edit') {
          AppDialogs.showEditBox(context, box: box);
        } else if (value == 'delete') {
          AppDialogs.showDeleteBoxConfirmation(context, box: box);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_outlined, size: 20),
              SizedBox(width: 12),
              Text('Edit name'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete_outline, size: 20, color: theme.colorScheme.error),
              const SizedBox(width: 12),
              Text('Delete', style: TextStyle(color: theme.colorScheme.error)),
            ],
          ),
        ),
      ],
    );
  }
}
