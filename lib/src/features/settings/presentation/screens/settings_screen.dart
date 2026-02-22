import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/di/injection_container.dart';
import 'package:bulk_box/src/core/theme/theme_extensions.dart';
import 'package:bulk_box/src/features/backup/presentation/cubit/backup_cubit.dart';
import 'package:bulk_box/src/features/backup/presentation/cubit/backup_state.dart';
import 'package:bulk_box/src/features/backup/presentation/widgets/backup_loading_overlay.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:bulk_box/src/features/settings/presentation/cubit/settings_state.dart';
import 'package:bulk_box/src/features/settings/presentation/widgets/settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BackupCubit>(
      create: (_) => getIt<BackupCubit>(),
      child: const _SettingsScreenContent(),
    );
  }
}

class _SettingsScreenContent extends StatelessWidget {
  const _SettingsScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardStyles = theme.extension<CardStyles>() ?? CardStyles.light;

    return BlocListener<BackupCubit, BackupState>(
      listener: (context, state) {
        state.whenOrNull(
          importSuccess: (result) {
            // Reset collection state and navigate to the boxes grid so the
            // user lands on fresh data and no stale box ID can cause an
            // empty-list view (box IDs change after a replace-mode import).
            getIt<CollectionCubit>().loadCollectionItems();
            getIt<BoxesCubit>().loadBoxes();
            context.go('/collection');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Import complete — ${result.itemsImported} item${result.itemsImported == 1 ? '' : 's'} imported.',
                ),
              ),
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: colorScheme.error,
              ),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Stack(
          children: [
            BlocBuilder<SettingsCubit, SettingsState>(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Bulk Box',
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: Dimensions.xs),
                                    Text(
                                      "I don't even know who you are.",
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
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
                            context
                                .read<SettingsCubit>()
                                .setShowDividers(value);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: Dimensions.lg),

                    // Data section
                    SettingsSection(
                      title: 'Data',
                      children: [
                        BlocBuilder<BackupCubit, BackupState>(
                          builder: (context, backupState) {
                            final isBusy = backupState.maybeWhen(
                              exporting: () => true,
                              importing: () => true,
                              orElse: () => false,
                            );
                            return Column(
                              children: [
                                Builder(
                                  builder: (tileContext) => SettingsTile(
                                    title: 'Export collection',
                                    subtitle:
                                        'Save your collection to a file',
                                    onTap: isBusy
                                        ? null
                                        : () {
                                            final box =
                                                tileContext.findRenderObject()
                                                    as RenderBox?;
                                            final rect = box != null
                                                ? box.localToGlobal(
                                                        Offset.zero) &
                                                    box.size
                                                : null;
                                            context.read<BackupCubit>().export(
                                                sharePositionOrigin: rect);
                                          },
                                  ),
                                ),
                                SettingsTile(
                                  title: 'Import collection',
                                  subtitle: 'Restore from a .bulkbox file',
                                  onTap: isBusy
                                      ? null
                                      : () => context
                                          .read<BackupCubit>()
                                          .pickAndImport(context),
                                ),
                                // DEBUG: remove before release
                                SettingsTile(
                                  title: '[DEBUG] Simulate import',
                                  subtitle:
                                      'Shows the loading overlay for 5 s',
                                  onTap: isBusy
                                      ? null
                                      : () => context
                                          .read<BackupCubit>()
                                          .debugSimulateImport(),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            // Full-screen loading overlay while export/import is in progress
            BlocBuilder<BackupCubit, BackupState>(
              builder: (context, backupState) {
                return backupState.maybeWhen(
                  exporting: () =>
                      const BackupLoadingOverlay.exporting(),
                  importing: () =>
                      const BackupLoadingOverlay.importing(),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
