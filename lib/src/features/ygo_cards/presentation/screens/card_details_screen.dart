import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/search/presentation/cubit/search_cubit.dart';
import 'dart:io';

import 'package:ygo_collector/src/features/ygo_cards/data/entities/ygo_card.dart';

class CardDetailsScreen extends StatelessWidget {
  final YgoCard card;

  const CardDetailsScreen({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(card.name, style: theme.textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Image
            AspectRatio(
              aspectRatio: 3 / 4,
              child: FutureBuilder<String>(
                future: context.read<SearchCubit>().getCardImagePath(card.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    return Image.file(
                      File(snapshot.data!),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/ygo_placeholder.jpg',
                          fit: BoxFit.contain,
                        );
                      },
                    );
                  }

                  return Image.asset(
                    'assets/images/ygo_placeholder.jpg',
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            const SizedBox(height: Dimensions.lg),

            // Card Details
            _buildDetailSection(
              context,
              title: 'Card Information',
              children: [
                _buildDetailRow('Type', card.type),
                _buildDetailRow('Race', card.race),
                if (card.attribute != null)
                  _buildDetailRow('Attribute', card.attribute!),
                if (card.level != null)
                  _buildDetailRow('Level', '${card.level}'),
                if (card.atk != null) _buildDetailRow('ATK', '${card.atk}'),
                if (card.def != null) _buildDetailRow('DEF', '${card.def}'),
              ],
            ),
            const SizedBox(height: Dimensions.md),

            // Set Information
            _buildDetailSection(
              context,
              title: 'Set Information',
              children: [
                for (final set in card.cardSets)
                  Card(
                    margin: const EdgeInsets.only(bottom: Dimensions.sm),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Set Name', set.setName),
                          _buildDetailRow('Set Code', set.setCode),
                          _buildDetailRow('Rarity', set.setRarity),
                          _buildDetailRow('Price', '\$${set.setPrice}'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Dimensions.md),

            // Card Description
            _buildDetailSection(
              context,
              title: 'Description',
              children: [
                Text(
                  card.description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: Dimensions.sm),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
