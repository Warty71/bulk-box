import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/widgets/app_search_bar.dart';
import 'package:bulk_box/src/core/di/injection_container.dart' as di;
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_state.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/widgets/search_filters_sheet.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFiltersSheet(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    final currentFilters = cubit.state.maybeWhen(
      loaded: (_, __, ___, lastFilters) => lastFilters,
      orElse: () => null,
    );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: SearchFiltersSheet(initialFilters: currentFilters),
      ),
    );
  }

  void _onConfirmAdd(int? boxId) async {
    final quickAddCubit = context.read<QuickAddCubit>();

    await quickAddCubit.confirmAdd(boxId: boxId);

    // Reload singletons so UI reacts to the new items
    di.getIt<CollectionCubit>().refresh();
    di.getIt<BoxesCubit>().loadBoxes();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cards added to collection')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search Cards',
            style: theme.textTheme.titleLarge,
          ),
        ),
        body: Column(
          children: [
            // Search bar + filter button
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimensions.md, Dimensions.sm, Dimensions.sm, Dimensions.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppSearchBar(
                      controller: _searchController,
                      hintText: 'Search by card name...',
                      textInputAction: TextInputAction.search,
                      onSubmitted: (query) {
                        context.read<SearchCubit>().searchCards(query);
                      },
                      onClear: () {
                        context.read<SearchCubit>().searchCards('');
                      },
                    ),
                  ),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      final filters = state.maybeWhen(
                        loaded: (_, __, ___, lastFilters) => lastFilters,
                        orElse: () => null,
                      );
                      final activeCount =
                          (filters != null && !filters.isEmpty)
                              ? filters.activeCount
                              : 0;
                      return Badge(
                        isLabelVisible: activeCount > 0,
                        label: Text('$activeCount'),
                        child: IconButton(
                          icon: const Icon(Icons.tune_rounded),
                          onPressed: () => _showFiltersSheet(context),
                          tooltip: 'Filter',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Results
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
                    loaded: (entries, grouped, lastQuery, lastFilters) {
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
      ),
    );
  }
}
