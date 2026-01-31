import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/theme/theme_extensions.dart';
import 'package:bulk_box/src/features/home/presentation/widgets/latest_sets_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardStyles = theme.extension<CardStyles>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bulk Box', style: theme.textTheme.titleLarge),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimensions.md),
        children: [
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
