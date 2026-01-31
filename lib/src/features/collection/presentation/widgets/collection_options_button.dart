import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/widgets/collection_options_bottom_sheet.dart';

// * This button opens a bottom sheet with the collection options
// * The bottom sheet contains the following options:
// * - Dividers: Add a divider between sections, depending on the selected sort option
class CollectionOptionsButton extends StatelessWidget {
  const CollectionOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        final collectionCubit = context.read<CollectionCubit>();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (sheetContext) => BlocProvider.value(
            value: collectionCubit,
            child: const CollectionOptionsBottomSheet(),
          ),
        );
      },
    );
  }
}
