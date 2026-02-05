import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/domain/entities/box_or_unboxed.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/utils/collection_navigation.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/box_grid_card.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/boxes_state_view.dart';
import 'package:bulk_box/src/core/widgets/app_dialogs.dart';

/// 2-column grid of boxes (Unboxed + user boxes). No app bar.
/// Tap a box to open cards in that box; FAB to create a new box.
class CollectionBoxesGridView extends StatelessWidget {
  const CollectionBoxesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<BoxesCubit>()..loadBoxes(),
      child: Builder(
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
                      onDelete: item.isUnboxed
                          ? null
                          : () => AppDialogs.showDeleteBoxConfirmation(
                                context,
                                box: item.box!,
                              ),
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
      ),
    );
  }
}
