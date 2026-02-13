import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/enums/rarity.dart';
import 'package:bulk_box/src/core/utils/set_code_utils.dart';
import 'package:bulk_box/src/core/widgets/quantity_stepper.dart';
import 'package:bulk_box/src/features/collection/domain/entities/box.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_state.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/quick_add_cart_sheet.dart';

/// Bottom bar with two modes:
/// - **Selection mode**: shows selected card name, set/rarity, and QuantityStepper.
/// - **Cart summary mode**: shows total card count + Add button.
class QuickAddBar extends StatelessWidget {
  final void Function(int? boxId) onConfirmAdd;

  const QuickAddBar({super.key, required this.onConfirmAdd});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuickAddCubit, QuickAddState>(
      builder: (context, state) {
        return AnimatedSlide(
          offset: state.barVisible ? Offset.zero : const Offset(0, 1),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            opacity: state.barVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: state.hasSelection
                ? _SelectionBar(
                    state: state,
                    onConfirmAdd: onConfirmAdd,
                  )
                : _CartSummaryBar(
                    state: state,
                    onConfirmAdd: onConfirmAdd,
                  ),
          ),
        );
      },
    );
  }
}

/// Bar when a card is selected — shows card info + quantity stepper.
class _SelectionBar extends StatelessWidget {
  final QuickAddState state;
  final void Function(int? boxId) onConfirmAdd;

  const _SelectionBar({required this.state, required this.onConfirmAdd});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = state.selectedItem;
    final key = state.selectedKey!;
    final qty = item?.quantity ?? 0;

    return Material(
      elevation: 8,
      color: theme.colorScheme.surfaceContainerHigh,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.md,
            vertical: Dimensions.sm,
          ),
          child: Row(
            children: [
              // Card info
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.card.name ?? '',
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${shortSetCode(item?.setCode ?? '')} - ${Rarity.getShortRarity(item?.setRarity ?? '')}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              // Quantity stepper
              QuantityStepper(
                value: qty,
                min: 0,
                onDecrease: () => context
                    .read<QuickAddCubit>()
                    .updateQuantity(key, qty - 1),
                onIncrease: () => context
                    .read<QuickAddCubit>()
                    .updateQuantity(key, qty + 1),
              ),
              // Cart badge + add button (when cart has items)
              if (state.hasItems) ...[
                const SizedBox(width: Dimensions.xs),
                _CartAddButton(
                  totalCount: state.totalCount,
                  onCartTap: () => _showCartSheet(context),
                  onAddTap: () => _showDestinationPicker(context),
                ),
              ],
            ],
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

/// Bar when no card is selected but cart has items — shows total + Add button.
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

/// Small cart badge that doubles as Add button.
class _CartAddButton extends StatelessWidget {
  final int totalCount;
  final VoidCallback onCartTap;
  final VoidCallback onAddTap;

  const _CartAddButton({
    required this.totalCount,
    required this.onCartTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onCartTap,
          borderRadius: BorderRadius.circular(Dimensions.radiusSm),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.xs),
            child: Badge(
              label: Text('$totalCount'),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 20,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: Dimensions.xs),
        FilledButton(
          onPressed: onAddTap,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
            minimumSize: const Size(0, 36),
          ),
          child: const Text('Add'),
        ),
      ],
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
