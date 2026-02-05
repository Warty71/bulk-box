import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/settings/settings_cubit.dart';
import 'package:bulk_box/src/core/settings/settings_state.dart';
import 'package:bulk_box/src/features/sorting/domain/entities/sort_options.dart';

/// Bottom sheet to pick collection sort option.
class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final selected = state.sortOption;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: SortOption.values
              .map(
                (option) => RadioListTile<SortOption>(
                  title: Text(option.label),
                  value: option,
                  groupValue: selected,
                  onChanged: (value) {
                    context.read<SettingsCubit>().setSortOption(value!);
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }
}
