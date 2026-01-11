import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/features/search/presentation/cubit/search_cubit.dart';

/// Cached image widget that prevents rebuilds
class CollectionCardImage extends StatefulWidget {
  final int cardId;

  const CollectionCardImage({
    super.key,
    required this.cardId,
  });

  @override
  State<CollectionCardImage> createState() => _CollectionCardImageState();
}

class _CollectionCardImageState extends State<CollectionCardImage> {
  Future<String>? _imagePathFuture;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    final searchCubit = context.read<SearchCubit>();
    _imagePathFuture = searchCubit.getCardImagePath(widget.cardId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.radiusSm),
      child: SizedBox(
        width: 80,
        height: 112,
        child: FutureBuilder<String>(
          future: _imagePathFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

            if (snapshot.hasData) {
              return Image.file(
                File(snapshot.data!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/ygo_placeholder.jpg',
                    fit: BoxFit.cover,
                  );
                },
              );
            }

            return Image.asset(
              'assets/images/ygo_placeholder.jpg',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
