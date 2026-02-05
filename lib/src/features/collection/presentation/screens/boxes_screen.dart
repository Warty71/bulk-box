import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/utils/color_utils.dart';
import 'package:bulk_box/src/core/widgets/app_dialogs.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/utils/collection_navigation.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/boxes_state_view.dart';

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
        body: BoxesStateView(
          contentBuilder: (boxes) => ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.inbox_outlined),
                ),
                title: const Text('Unboxed'),
                subtitle: const Text('Items not in any box'),
                onTap: () => context.goCollectionBox(null),
              ),
              ...boxes.map(
                (box) => _BoxListTile(
                  box: box,
                  onTap: () => context.goCollectionBox(box),
                  onDelete: () =>
                      AppDialogs.showDeleteBoxConfirmation(context, box: box),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AppDialogs.showCreateBox(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _BoxListTile extends StatelessWidget {
  final Box box;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _BoxListTile({
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
                ? parseHexColor(box.color!)
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
}
