import 'package:flutter/material.dart';

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

    // auto focus when shown
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

    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(14),
      color: theme.colorScheme.surface,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        //onChanged: (value) => context.read<CollectionCubit>().search(value),
        decoration: InputDecoration(
          hintText: 'Search your collection...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _controller.clear();
                    //context.read<CollectionCubit>().search('');
                    setState(() {});
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }
}
