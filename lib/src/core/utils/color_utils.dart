import 'package:flutter/material.dart';

/// Parses a hex color string (e.g. "#RRGGBB" or "RRGGBB") to [Color].
/// Returns [Colors.grey] if parsing fails.
Color parseHexColor(String hex) {
  try {
    final c = hex.replaceFirst('#', '');
    if (c.length == 6) {
      return Color(int.parse('FF$c', radix: 16));
    }
  } catch (_) {}
  return Colors.grey;
}
