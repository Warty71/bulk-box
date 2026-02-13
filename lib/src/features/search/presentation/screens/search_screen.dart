import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/widgets/debouncer.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_state.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_sectioned_list_view.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/quick_add_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.getIt<SearchCubit>()),
        BlocProvider(create: (_) => di.getIt<QuickAddCubit>()),
        BlocProvider.value(value: di.getIt<CollectionCubit>()),
      ],
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();
  final _debounce = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onConfirmAdd(int? boxId) async {
    final quickAddCubit = context.read<QuickAddCubit>();
    final collectionCubit = di.getIt<CollectionCubit>();
    final boxesCubit = di.getIt<BoxesCubit>();

    await quickAddCubit.confirmAdd(
      boxId: boxId,
      collectionCubit: collectionCubit,
      boxesCubit: boxesCubit,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cards added to collection')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Cards', style: theme.textTheme.titleLarge),
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by card name...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<SearchCubit>().searchCards('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.3),
              ),
              onChanged: (query) {
                _debounce.run(() {
                  context.read<SearchCubit>().searchCards(query);
                });
              },
            ),
          ),

          // Results body
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(
                    child: Text('Search for Yu-Gi-Oh! cards'),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (entries, grouped, lastQuery) {
                    if (entries.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 48,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: Dimensions.md),
                            Text(
                              'No cards found matching "${_searchController.text}"',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        SearchSectionedListView(grouped: grouped),
                        // QuickAddBar at bottom
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: QuickAddBar(onConfirmAdd: _onConfirmAdd),
                        ),
                      ],
                    );
                  },
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: $message'),
                        const SizedBox(height: Dimensions.md),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<SearchCubit>()
                                .searchCards(_searchController.text);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
