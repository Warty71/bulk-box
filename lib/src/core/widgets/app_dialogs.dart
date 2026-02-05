import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';

/// Single entry point for app dialogs (create box, delete box confirmation, etc.).
class AppDialogs {
  AppDialogs._();

  /// Shows "New box" dialog; on Create, calls [BoxesCubit.createBox] with the name.
  /// Requires [BoxesCubit] in context.
  static Future<void> showCreateBox(BuildContext context) async {
    final nameController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('New box'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Box name',
            hintText: 'e.g. Starlight Rares',
          ),
          autofocus: true,
          onSubmitted: (_) => _submitCreate(context, dialogContext, nameController),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                _submitCreate(context, dialogContext, nameController),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  static void _submitCreate(
    BuildContext context,
    BuildContext dialogContext,
    TextEditingController nameController,
  ) {
    final name = nameController.text.trim();
    if (name.isEmpty) return;

    Navigator.of(dialogContext).pop();
    context.read<BoxesCubit>().createBox(name: name);
  }

  /// Shows "Delete box?" confirmation; on confirm, calls [BoxesCubit.deleteBox].
  /// Requires [BoxesCubit] in context.
  static Future<void> showDeleteBoxConfirmation(
    BuildContext context, {
    required Box box,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete box?'),
        content: Text(
          'Delete "${box.name}"? Items inside will be moved to Unboxed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<BoxesCubit>().deleteBox(box.id);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
