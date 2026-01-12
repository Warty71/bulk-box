import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/features/search/presentation/cubit/search_cubit.dart';

class CollectionCardImageDialog extends StatelessWidget {
  final int cardId;

  const CollectionCardImageDialog({
    super.key,
    required this.cardId,
  });

  static void show(BuildContext context, int cardId) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<SearchCubit>(),
        child: CollectionCardImageDialog(cardId: cardId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Center(
            child: FutureBuilder<String>(
              future: searchCubit.getCardImagePath(cardId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
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
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
