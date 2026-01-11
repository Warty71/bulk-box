import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/theme/theme_extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardStyles = theme.extension<CardStyles>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text('YGO Collector', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimensions.md),
        children: [
          // Recent Activity Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: cardStyles.cardPadding,
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
                    'Added Blue-Eyes White Dragon',
                    '2 hours ago',
                    Icons.add_circle_outline,
                  ),
                  const Divider(),
                  _buildActivityItem(
                    context,
                    'Updated Dark Magician condition',
                    '5 hours ago',
                    Icons.edit_outlined,
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
              padding: cardStyles.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collection Stats',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: Dimensions.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(context, 'Total Cards', '1,234'),
                      _buildStatItem(context, 'Sets Complete', '3'),
                      _buildStatItem(context, 'Wish List', '25'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimensions.md),

          // Latest Sets Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: cardStyles.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Sets',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: Dimensions.md),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: Dimensions.md),
                      itemBuilder: (context, index) {
                        return _buildSetCard(context, 'Set ${index + 1}');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String time,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.sm),
      child: Row(
        children: [
          Icon(icon, size: Dimensions.iconMd),
          const SizedBox(width: Dimensions.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  time,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineLarge,
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

  Widget _buildSetCard(BuildContext context, String setName) {
    final theme = Theme.of(context);
    final cardStyles = theme.extension<CardStyles>()!;

    return Container(
      width: 120,
      decoration: cardStyles.cardDecoration,
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.radiusMd),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.image_outlined,
                size: Dimensions.iconXl,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.sm),
            child: Text(
              setName,
              style: theme.textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
