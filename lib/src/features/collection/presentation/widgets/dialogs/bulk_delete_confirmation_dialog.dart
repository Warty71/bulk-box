import 'package:flutter/material.dart';

class BulkDeleteConfirmationDialog extends StatelessWidget {
  const BulkDeleteConfirmationDialog({super.key, required this.count});

  final int count;

  static Future<bool?> show(BuildContext context, {required int count}) {
    return showDialog<bool>(
      context: context,
      builder: (_) => BulkDeleteConfirmationDialog(count: count),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      icon: Icon(
        Icons.delete_forever,
        color: colorScheme.error,
        size: 36,
      ),
      title: Text('Delete $count card${count == 1 ? '' : 's'}?'),
      content: Text(
        'This will permanently remove the selected cards from your '
        'collection. This action cannot be undone.',
        style: textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
