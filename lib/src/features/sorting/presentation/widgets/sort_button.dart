import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/features/sorting/presentation/cubits/sort_cubit.dart';
import 'package:ygo_collector/src/features/sorting/presentation/cubits/sort_state.dart';
import 'package:ygo_collector/src/features/sorting/domain/entities/sort_options.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortCubit, SortState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () {
            _showSortSheet(context, state.option);
          },
        );
      },
    );
  }

  void _showSortSheet(BuildContext context, SortOption selected) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: SortOption.values.map((option) {
            return RadioListTile<SortOption>(
              title: Text(_label(option)),
              value: option,
              groupValue: selected,
              onChanged: (value) {
                context.read<SortCubit>().setSort(value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  String _label(SortOption option) {
    switch (option) {
      case SortOption.nameAZ:
        return 'Name (A–Z)';
      case SortOption.cardType:
        return 'Card Type';
    }
  }
}
