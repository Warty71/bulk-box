import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/widgets/quantity_stepper.dart';

/// One row: box name, "Owned: x", and +/- quantity stepper.
class SlotTile extends StatelessWidget {
  final String boxName;
  final int quantity;
  final bool isSaving;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const SlotTile({
    super.key,
    required this.boxName,
    required this.quantity,
    required this.isSaving,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        boxName,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text('Owned: $quantity'),
      trailing: QuantityStepper(
        value: quantity,
        min: 0,
        max: 999,
        enabled: !isSaving,
        valueWidth: 32,
        onDecrease: onDecrease,
        onIncrease: onIncrease,
      ),
    );
  }
}
