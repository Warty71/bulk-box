import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_state.dart';

class BoxesScreen extends StatelessWidget {
  const BoxesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<BoxesCubit>()..loadBoxes(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Boxes'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/collection'),
          ),
        ),
        body: BlocBuilder<BoxesCubit, BoxesState>(
          builder: (context, state) {
            if (state is BoxesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is BoxesError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            if (state is BoxesLoaded) {
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _UnboxedTile(
                    onTap: () => context.go('/collection?filter=unboxed'),
                  ),
                  ...state.boxes.map(
                    (box) => _BoxTile(
                      box: box,
                      itemCount: 0, // Will load async if needed
                      onTap: () => context.go(
                        '/collection?box=${box.id}&name=${Uri.encodeComponent(box.name)}',
                      ),
                      onDelete: () => _confirmDeleteBox(context, box),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreateBoxDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showCreateBoxDialog(BuildContext context) {
    final nameController = TextEditingController();

    showDialog<void>(
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
          onSubmitted: (_) => _submitCreateBox(context, dialogContext, nameController),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => _submitCreateBox(context, dialogContext, nameController),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _submitCreateBox(
    BuildContext context,
    BuildContext dialogContext,
    TextEditingController nameController,
  ) {
    final name = nameController.text.trim();
    if (name.isEmpty) return;

    Navigator.of(dialogContext).pop();
    context.read<BoxesCubit>().createBox(name: name);
  }

  void _confirmDeleteBox(BuildContext context, Box box) {
    showDialog<void>(
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

class _UnboxedTile extends StatelessWidget {
  final VoidCallback onTap;

  const _UnboxedTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.inbox_outlined),
      ),
      title: const Text('Unboxed'),
      subtitle: const Text('Items not in any box'),
      onTap: onTap,
    );
  }
}

class _BoxTile extends StatelessWidget {
  final Box box;
  final int itemCount;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _BoxTile({
    required this.box,
    required this.itemCount,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return _BoxTileContent(
      box: box,
      onTap: onTap,
      onDelete: onDelete,
    );
  }
}

class _BoxTileContent extends StatelessWidget {
  final Box box;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _BoxTileContent({
    required this.box,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: context.read<BoxesCubit>().countItemsInBox(box.id),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: box.color != null
                ? _parseColor(box.color!)
                : Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              box.name.isNotEmpty ? box.name[0].toUpperCase() : '?',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          title: Text(box.name),
          subtitle: Text('$count item${count == 1 ? '' : 's'}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
          ),
          onTap: onTap,
        );
      },
    );
  }

  Color _parseColor(String hex) {
    try {
      final c = hex.replaceFirst('#', '');
      if (c.length == 6) {
        return Color(int.parse('FF$c', radix: 16));
      }
    } catch (_) {}
    return Colors.grey;
  }
}
