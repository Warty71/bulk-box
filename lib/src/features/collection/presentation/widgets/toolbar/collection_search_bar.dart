import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/widgets/app_search_bar.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';

class CollectionSearchBar extends StatefulWidget {
  const CollectionSearchBar({super.key});

  @override
  State<CollectionSearchBar> createState() => _CollectionSearchBarState();
}

class _CollectionSearchBarState extends State<CollectionSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.md),
      child: AppSearchBar(
        controller: _controller,
        hintText: 'Search your collection...',
        onChanged: (query) {
          context.read<CollectionCubit>().search(query);
        },
        onClear: () {
          context.read<CollectionCubit>().search('');
        },
      ),
    );
  }
}
