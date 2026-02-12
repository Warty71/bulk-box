import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/theme/theme_extensions.dart';

/// A card-styled group of [SettingsTile] or [SettingsSwitchTile] children
/// with a header label above.
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardStyles = theme.extension<CardStyles>() ?? CardStyles.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        const SizedBox(height: Dimensions.sm),
        Container(
          decoration: BoxDecoration(
            borderRadius: cardStyles.cardBorderRadius,
            boxShadow: cardStyles.cardDecoration.boxShadow,
          ),
          child: Material(
            color: cardStyles.cardDecoration.color,
            clipBehavior: Clip.antiAlias,
            borderRadius: cardStyles.cardBorderRadius,
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}

/// A [ListTile] with an opinionated subtitle style for settings screens.
class SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: _subtitleStyle(context)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

/// A [SwitchListTile] with an opinionated subtitle style for settings screens.
class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: _subtitleStyle(context)),
      value: value,
      onChanged: onChanged,
    );
  }
}

TextStyle? _subtitleStyle(BuildContext context) {
  final theme = Theme.of(context);
  return theme.textTheme.bodySmall?.copyWith(
    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
  );
}
