import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/quick_add_cart_sheet.dart';

/// Bottom bar showing cart total + Add button when the cart has items.
class QuickAddBar extends StatelessWidget {
  final void Function(int? boxId) onConfirmAdd;

  const QuickAddBar({super.key, required this.onConfirmAdd});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuickAddCubit, QuickAddState>(
      builder: (context, state) {
        return AnimatedSlide(
          offset: state.hasItems ? Offset.zero : const Offset(0, 1),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            opacity: state.hasItems ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: _CartSummaryBar(
              state: state,
              onConfirmAdd: onConfirmAdd,
            ),
          ),
        );
      },
    );
  }
}

/// Bar showing cart total count, Clear button, and Add button.
class _CartSummaryBar extends StatelessWidget {
  final QuickAddState state;
  final void Function(int? boxId) onConfirmAdd;

  const _CartSummaryBar({required this.state, required this.onConfirmAdd});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 8,
      color: theme.colorScheme.surfaceContainerHigh,
      child: SafeArea(
        top: false,
        child: InkWell(
          onTap: () => _showCartSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.md,
              vertical: Dimensions.sm,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: Dimensions.sm),
                Expanded(
                  child: Text(
                    '${state.totalCount} card${state.totalCount == 1 ? '' : 's'}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.read<QuickAddCubit>().clearCart(),
                  child: const Text('Clear'),
                ),
                const SizedBox(width: Dimensions.xs),
                FilledButton(
                  onPressed: () => _showDestinationPicker(context),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCartSheet(BuildContext context) {
    final cubit = context.read<QuickAddCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: QuickAddCartSheet(
          onAddPressed: () => _showDestinationPicker(context),
        ),
      ),
    );
  }

  void _showDestinationPicker(BuildContext context) {
    final cubit = context.read<QuickAddCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: _DestinationPickerSheet(onConfirmAdd: onConfirmAdd),
      ),
    );
  }
}

/// Destination picker: Unboxed or a specific box.
class _DestinationPickerSheet extends StatefulWidget {
  final void Function(int? boxId) onConfirmAdd;

  const _DestinationPickerSheet({required this.onConfirmAdd});

  @override
  State<_DestinationPickerSheet> createState() =>
      _DestinationPickerSheetState();
}

class _DestinationPickerSheetState extends State<_DestinationPickerSheet> {
  List<Box> _boxes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBoxes();
  }

  Future<void> _loadBoxes() async {
    final boxRepo = di.getIt<BoxRepository>();
    final boxes = await boxRepo.getBoxes();
    if (!mounted) return;
    setState(() {
      _boxes = boxes;
      _loading = false;
    });
  }

  void _pick(int? boxId) {
    widget.onConfirmAdd(boxId);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalCount = context.read<QuickAddCubit>().state.totalCount;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: Row(
              children: [
                Icon(
                  Icons.add_box_outlined,
                  size: 28,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: Dimensions.sm),
                Expanded(
                  child: Text(
                    'Add $totalCount card${totalCount == 1 ? '' : 's'} to...',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(
              Icons.inbox_outlined,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            title: const Text('Unboxed'),
            onTap: () => _pick(null),
          ),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(Dimensions.md),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            for (final box in _boxes)
              ListTile(
                leading: Icon(
                  Icons.inventory_2_outlined,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                title: Text(box.name),
                onTap: () => _pick(box.id),
              ),
        ],
      ),
    );
  }
}
