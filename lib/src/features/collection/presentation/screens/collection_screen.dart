import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/screens/collection_view.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/boxes/collection_boxes_grid_view.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';

class CollectionScreen extends StatelessWidget {
  /// Filter by box; null = show boxes grid.
  final int? boxId;
  /// When true, show only unboxed items (cards).
  final bool filterUnboxed;
  /// Display name for the current filter (e.g. "Unboxed" or box name).
  final String? boxName;

  const CollectionScreen({
    super.key,
    this.boxId,
    this.filterUnboxed = false,
    this.boxName,
  });

  /// True when we should show cards inside a box (or unboxed); false = show boxes grid.
  bool get _showingCards => boxId != null || filterUnboxed;

  @override
  Widget build(BuildContext context) {
    if (!_showingCards) {
      return const CollectionBoxesGridView();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<CollectionCubit>()
            ..loadCollectionItems(
              boxId: boxId,
              unboxedOnly: filterUnboxed,
              boxName: boxName ?? (filterUnboxed ? 'Unboxed' : null),
            ),
        ),
        BlocProvider(
          create: (context) => di.getIt<SearchCubit>(),
        ),
      ],
      child: const CollectionView(),
    );
  }
}
