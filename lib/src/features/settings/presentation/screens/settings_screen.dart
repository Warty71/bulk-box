import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/settings/settings_cubit.dart';
import 'package:bulk_box/src/core/settings/settings_state.dart';
import 'package:bulk_box/src/core/theme/theme_extensions.dart';
import 'package:bulk_box/src/features/settings/presentation/widgets/settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _version = '1.0.0+5';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardStyles = theme.extension<CardStyles>() ?? CardStyles.light;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(Dimensions.md),
            children: [
              // App info card
              Container(
                decoration: BoxDecoration(
                  borderRadius: cardStyles.cardBorderRadius,
                  boxShadow: cardStyles.cardDecoration.boxShadow,
                ),
                child: Material(
                  color: cardStyles.cardDecoration.color,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: cardStyles.cardBorderRadius,
                  child: Padding(
                    padding: cardStyles.cardPadding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: Dimensions.md),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bulk Box',
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: Dimensions.xs),
                              Text(
                                "I don't even know who you are.",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: Dimensions.lg),

              // Collection section
              SettingsSection(
                title: 'Collection',
                children: [
                  SettingsSwitchTile(
                    title: 'Box-exclusive sorting',
                    subtitle:
                        'Each box remembers its own sort choice instead of using a global one',
                    value: state.boxExclusiveSorting,
                    onChanged: (value) {
                      context
                          .read<SettingsCubit>()
                          .setBoxExclusiveSorting(value);
                    },
                  ),
                  SettingsSwitchTile(
                    title: 'Show section dividers',
                    subtitle:
                        'Group cards by letter (A\u2013Z) or card type based on sort',
                    value: state.showDividers,
                    onChanged: (value) {
                      context.read<SettingsCubit>().setShowDividers(value);
                    },
                  ),
                ],
              ),

              const SizedBox(height: Dimensions.lg),

              // About section
              SettingsSection(
                title: 'About',
                children: [
                  SettingsTile(
                    title: 'Version',
                    subtitle: 'Current app version and build number',
                    trailing: Text(
                      _version,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
