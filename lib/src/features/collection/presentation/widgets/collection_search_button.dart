import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';

class CollectionSearchButton extends StatelessWidget {
  const CollectionSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CollectionCubit>().toggleSearchBar();
      },
      shape: const CircleBorder(),
      child: const Icon(Icons.search),
    );
  }
}
