import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/widgets/app_bottom_sheets.dart';

/// Button that opens the collection options bottom sheet (dividers, etc.).
class CollectionOptionsButton extends StatelessWidget {
  const CollectionOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => AppBottomSheets.showCollectionOptions(context),
    );
  }
}
