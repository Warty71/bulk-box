import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimensions.md),
        children: [
          // Profile Header Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: Dimensions.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: theme.textTheme.headlineSmall,
                        ),
                        Text(
                          'Collector since 2023',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: Dimensions.md),

          // Collection Stats Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collection Overview',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: Dimensions.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        context,
                        'Cards',
                        '1,234',
                        Icons.style,
                      ),
                      _buildStatItem(
                        context,
                        'Sets',
                        '45',
                        Icons.grid_view,
                      ),
                      _buildStatItem(
                        context,
                        'Value',
                        '\$2.5K',
                        Icons.attach_money,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: Dimensions.md),

          // Recent Activity Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: Dimensions.md),
                  _buildActivityItem(
                    context,
                    'Added new card',
                    'Blue-Eyes White Dragon',
                    '2 hours ago',
                    Icons.add_circle_outline,
                  ),
                  const Divider(),
                  _buildActivityItem(
                    context,
                    'Updated condition',
                    'Dark Magician',
                    '5 hours ago',
                    Icons.edit_outlined,
                  ),
                  const Divider(),
                  _buildActivityItem(
                    context,
                    'Sold card',
                    'Red-Eyes Black Dragon',
                    'Yesterday',
                    Icons.sell_outlined,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: Dimensions.md),

          // Settings Section
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                _buildSettingsItem(
                  context,
                  'Account Settings',
                  Icons.manage_accounts,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context,
                  'Notifications',
                  Icons.notifications_outlined,
                  onTap: () {},
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  context,
                  'Privacy',
                  Icons.privacy_tip_outlined,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(
          icon,
          size: Dimensions.iconLg,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: Dimensions.xs),
        Text(
          value,
          style: theme.textTheme.titleLarge,
        ),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String action,
    String cardName,
    String time,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.sm),
      child: Row(
        children: [
          Icon(
            icon,
            size: Dimensions.iconMd,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: Dimensions.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action,
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  cardName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge,
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}
