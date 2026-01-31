import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/theme/theme_extensions.dart';
import 'package:ygo_collector/src/features/home/presentation/widgets/collection_stat_item.dart';
import 'package:ygo_collector/src/features/home/presentation/widgets/latest_sets_section.dart';

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
                      CollectionStatItem(label: 'Total Cards', value: '1,234'),
                      CollectionStatItem(label: 'Sets Complete', value: '3'),
                      CollectionStatItem(label: 'Wish List', value: '25'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimensions.md),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: cardStyles.cardPadding,
              child: const LatestSetsSection(),
            ),
          ),
        ],
      ),
    );
  }
}
