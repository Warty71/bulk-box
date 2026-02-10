import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/widgets/app_dialogs.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';

class BoxOptionsBottomSheet extends StatelessWidget {
  final Box box;

  const BoxOptionsBottomSheet({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              box.name,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: Dimensions.md),
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit name'),
              onTap: () {
                Navigator.pop(context);
                AppDialogs.showEditBox(context, box: box);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline, color: theme.colorScheme.error),
              title: Text('Delete', style: TextStyle(color: theme.colorScheme.error)),
              onTap: () {
                Navigator.pop(context);
                AppDialogs.showDeleteBoxConfirmation(context, box: box);
              },
            ),
          ],
        ),
      ),
    );
  }
}
