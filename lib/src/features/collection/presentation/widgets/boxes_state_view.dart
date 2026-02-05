import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_state.dart';

/// Renders [BoxesState]: loading spinner, error message, or [contentBuilder] when loaded.
class BoxesStateView extends StatelessWidget {
  final Widget Function(List<Box> boxes) contentBuilder;

  const BoxesStateView({
    super.key,
    required this.contentBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoxesCubit, BoxesState>(
      builder: (context, state) {
        if (state is BoxesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BoxesError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is BoxesLoaded) {
          return contentBuilder(state.boxes);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
