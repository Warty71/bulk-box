import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';

class CollectionOptionsBottomSheet extends StatelessWidget {
  const CollectionOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.lg,
          horizontal: Dimensions.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Collection Options',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: Dimensions.md),
            BlocBuilder<CollectionCubit, CollectionState>(
              builder: (context, state) {
                final showDividers = state.maybeWhen(
                  loaded: (_, showDividers) => showDividers,
                  orElse: () => false,
                );

                return SwitchListTile(
                  value: showDividers,
                  onChanged: (value) {
                    context.read<CollectionCubit>().setShowDividersBetweenSections(value);
                  },
                  title: const Text('Show section dividers'),
                  subtitle: Text(
                    'Group cards by letter (A–Z) or card type based on sort',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.7),
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
