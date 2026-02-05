import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/widgets/app_bottom_sheets.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.sort),
      onPressed: () => AppBottomSheets.showSort(context),
    );
  }
}
