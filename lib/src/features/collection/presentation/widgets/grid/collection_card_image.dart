import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/ygo_cards/domain/repositories/image_repository.dart';

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
    _imagePathFuture =
        di.getIt<ImageRepository>().getCardImagePath(widget.cardId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 80,
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
    );
  }
}
