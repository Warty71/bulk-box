import 'package:flutter/material.dart';

/// Reusable - / value / + controls using circle outline icons.
/// Use for quantity editing (e.g. owned count, move amount).
class QuantityStepper extends StatelessWidget {
  final int value;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  final int min;
  final int max;
  final bool enabled;
  final double? valueWidth;

  const QuantityStepper({
    super.key,
    required this.value,
    this.onDecrease,
    this.onIncrease,
    this.min = 0,
    this.max = 999,
    this.enabled = true,
    this.valueWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canDecrease = enabled && value > min;
    final canIncrease = enabled && value < max;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: canDecrease ? onDecrease : null,
        ),
        SizedBox(
          width: valueWidth ?? 40,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: canIncrease ? onIncrease : null,
        ),
      ],
    );
  }
}
