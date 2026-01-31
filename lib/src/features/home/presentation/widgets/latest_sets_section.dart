import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/home/presentation/cubit/latest_sets_cubit.dart';
import 'package:ygo_collector/src/features/home/presentation/cubit/latest_sets_state.dart';
import 'package:ygo_collector/src/features/home/presentation/widgets/set_card.dart';

class LatestSetsSection extends StatelessWidget {
  const LatestSetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Sets',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: Dimensions.md),
        SizedBox(
          height: 180,
          child: BlocBuilder<LatestSetsCubit, LatestSetsState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                loading: () => const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                loaded: (sets) {
                  if (sets.isEmpty) {
                    return Center(
                      child: Text(
                        'No sets found',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: sets.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: Dimensions.md),
                    itemBuilder: (context, index) {
                      return SetCard(set: sets[index]);
                    },
                  );
                },
                failure: (message) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message ?? 'Failed to load sets',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Dimensions.sm),
                      TextButton(
                        onPressed: () => context.read<LatestSetsCubit>().load(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
