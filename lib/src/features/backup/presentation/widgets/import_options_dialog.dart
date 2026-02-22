import 'package:flutter/material.dart';
import 'package:bulk_box/src/features/backup/presentation/cubit/import_mode.dart';

class ImportOptionsDialog extends StatelessWidget {
  const ImportOptionsDialog({super.key});

  static Future<ImportMode?> show(BuildContext context) {
    return showDialog<ImportMode>(
      context: context,
      builder: (_) => const ImportOptionsDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      icon: Icon(Icons.upload_file, color: colorScheme.primary, size: 36),
      title: const Text('Import collection'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How would you like to import this backup?',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Text(
            'Merge — adds cards from the backup to your existing collection. '
            'Overlapping slots have their quantities summed.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Replace — deletes your entire current collection and replaces it '
            'with the backup. This cannot be undone.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.error.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(ImportMode.merge),
          child: const Text('Merge'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
          ),
          onPressed: () => Navigator.of(context).pop(ImportMode.replace),
          child: const Text('Replace'),
        ),
      ],
    );
  }
}
