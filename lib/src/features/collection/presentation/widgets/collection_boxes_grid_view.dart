import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_state.dart';

/// 2-column grid of boxes (Unboxed + user boxes). No app bar.
/// Tap a box to open cards in that box; FAB to create a new box.
class CollectionBoxesGridView extends StatelessWidget {
  const CollectionBoxesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<BoxesCubit>()..loadBoxes(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Boxes'),
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
              final items = [
                _GridItem.unboxed(),
                ...state.boxes.map((b) => _GridItem.box(b)),
              ];
              return GridView.builder(
                padding: const EdgeInsets.all(Dimensions.md),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimensions.md,
                  crossAxisSpacing: Dimensions.md,
                  childAspectRatio: 0.85,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _BoxGridCard(
                    item: item,
                    onTap: () => _onTap(context, item),
                    onDelete: item.isUnboxed
                        ? null
                        : () => _confirmDeleteBox(context, item.box!),
                  );
                },
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

  void _onTap(BuildContext context, _GridItem item) {
    if (item.isUnboxed) {
      context.push('/collection/box/unboxed');
    } else {
      context.push(
        '/collection/box/${item.box!.id}?name=${Uri.encodeComponent(item.box!.name)}',
      );
    }
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
          onSubmitted: (_) =>
              _submitCreateBox(context, dialogContext, nameController),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                _submitCreateBox(context, dialogContext, nameController),
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

class _GridItem {
  final bool isUnboxed;
  final Box? box;

  _GridItem._({required this.isUnboxed, this.box});

  factory _GridItem.unboxed() => _GridItem._(isUnboxed: true);

  factory _GridItem.box(Box box) => _GridItem._(isUnboxed: false, box: box);
}

class _BoxGridCard extends StatelessWidget {
  final _GridItem item;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _BoxGridCard({
    required this.item,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (item.isUnboxed) {
      return _BuildCard(
        icon: Icons.inbox_outlined,
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        title: 'Unboxed',
        subtitle: 'Items not in any box',
        onTap: onTap,
        onDelete: null,
      );
    }

    return BlocProvider.value(
      value: context.read<BoxesCubit>(),
      child: _BoxGridCardWithCount(
        box: item.box!,
        onTap: onTap,
        onDelete: onDelete,
      ),
    );
  }
}

class _BoxGridCardWithCount extends StatelessWidget {
  final Box box;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _BoxGridCardWithCount({
    required this.box,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: context.read<BoxesCubit>().countItemsInBox(box.id),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        final backgroundColor = box.color != null
            ? _parseColor(box.color!)
            : Theme.of(context).colorScheme.primaryContainer;
        return _BuildCard(
          icon: Icons.inventory_2_outlined,
          backgroundColor: backgroundColor,
          title: box.name,
          subtitle: '$count item${count == 1 ? '' : 's'}',
          onTap: onTap,
          onDelete: onDelete,
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

class _BuildCard extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _BuildCard({
    required this.icon,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderRadius = BorderRadius.circular(Dimensions.radiusMd);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: backgroundColor,
                      child: Icon(
                        icon,
                        size: Dimensions.iconXl,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimensions.xs),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            if (onDelete != null)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                  style: IconButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
