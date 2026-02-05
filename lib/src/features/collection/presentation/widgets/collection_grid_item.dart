import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/core/enums/rarity.dart';
import 'package:bulk_box/src/features/collection/domain/entities/collection_entry.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:bulk_box/src/features/collection/presentation/widgets/collection_card_details_bottom_sheet.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';

/// Short set code: first part before hyphen (e.g. DUNE-EN001 -> DUNE).
String _shortSetCode(String setCode) {
  final i = setCode.indexOf('-');
  return i > 0 ? setCode.substring(0, i) : setCode;
}

/// Grid item widget for displaying a card in the collection grid view
class CollectionGridItem extends StatelessWidget {
  final CollectionEntry entry;
  final int totalQuantity;

  const CollectionGridItem({
    super.key,
    required this.entry,
    required this.totalQuantity,
  });

  static Widget _badge(
    BuildContext context, {
    required String label,
    Color? backgroundColor,
  }) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final fg = theme.colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          final collectionCubit = context.read<CollectionCubit>();
          final state = collectionCubit.state;
          final currentBoxId = state.maybeWhen(
            loaded: (_, __, ___, boxId, ____) => boxId,
            orElse: () => null,
          );
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) => CollectionCardDetailsBottomSheet(
              entry: entry,
              collectionCubit: collectionCubit,
              currentBoxId: currentBoxId,
            ),
          );
        },
        child: Stack(
          children: [
            // Card Image
            FutureBuilder<String>(
              future:
                  di.getIt<SearchRepository>().getCardImagePath(entry.card.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return Image.asset(
                    'assets/images/ygo_placeholder.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                  );
                }

                return Image.file(
                  File(snapshot.data!),
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/ygo_placeholder.jpg',
                      fit: BoxFit.contain,
                      width: double.infinity,
                    );
                  },
                );
              },
            ),
            // Print cluster: set + rarity in a row (bottom-left)
            Positioned(
              left: 8,
              bottom: 8,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _badge(context, label: _shortSetCode(entry.setCode)),
                  const SizedBox(width: 4),
                  _badge(context, label: Rarity.getShortRarity(entry.setRarity)),
                ],
              ),
            ),
            // Quantity Badge
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'x$totalQuantity',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
