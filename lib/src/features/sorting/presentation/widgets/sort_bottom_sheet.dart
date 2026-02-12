import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/settings/settings_cubit.dart';
import 'package:bulk_box/src/core/settings/settings_state.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

/// Bottom sheet to pick collection sort option.
class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key, this.boxKey});

  final String? boxKey;

  static final _sortedOptions = List<SortOption>.from(SortOption.values)
    ..sort((a, b) => a.label.compareTo(b.label));

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
              'Sort Options',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: Dimensions.xs),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                final settingsCubit = context.read<SettingsCubit>();
                final selected = settingsCubit.effectiveSortOption(boxKey);
                final isBoxExclusive = state.boxExclusiveSorting;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBoxExclusive
                          ? 'Sort Options are Box-Exclusive.'
                          : 'Sort Options are Universal.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.6),
                          ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    ..._sortedOptions.map((option) {
                      final isSelected = option == selected;
                      return ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -2),
                        title: Text(option.label),
                        subtitle: Text(
                          option.description,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                        onTap: () {
                          if (isBoxExclusive && boxKey != null) {
                            settingsCubit.setBoxSortOption(boxKey!, option);
                          } else {
                            settingsCubit.setSortOption(option);
                          }
                        },
                      );
                    }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
