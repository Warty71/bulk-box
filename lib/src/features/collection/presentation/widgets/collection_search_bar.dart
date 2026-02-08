import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';

class CollectionSearchBar extends StatefulWidget {
  const CollectionSearchBar({super.key});

  @override
  State<CollectionSearchBar> createState() => _CollectionSearchBarState();
}

class _CollectionSearchBarState extends State<CollectionSearchBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (query) =>
          context.read<CollectionCubit>().search(query),
      decoration: InputDecoration(
        hintText: 'Search your collection...',
        prefixIcon: const Icon(Icons.search),

        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (_, value, __) {
            if (value.text.isEmpty) return const SizedBox.shrink();

            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _controller.clear();
                context.read<CollectionCubit>().search('');
              },
            );
          },
        ),

        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest
            .withValues(alpha: 0.3),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Dimensions.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Dimensions.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Dimensions.radiusMd),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
