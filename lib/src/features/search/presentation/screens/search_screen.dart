import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/constants/dimensions.dart';
import 'package:ygo_collector/src/core/widgets/debouncer.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_state.dart';
import 'package:ygo_collector/src/features/collection/domain/entities/card.dart'
    as entities;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<CollectionCubit>(),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Cards', style: theme.textTheme.titleLarge),
      ),
      body: Column(
        children: [
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
                    context.read<CollectionCubit>().searchCards('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              ),
              onChanged: (query) {
                _debounce.run(() {
                  context.read<CollectionCubit>().searchCards(query);
                });
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<CollectionCubit, CollectionState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(
                    child: Text('Search for Yu-Gi-Oh! cards'),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (cards, hasReachedMax) => cards.isEmpty
                      ? Center(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(Dimensions.md),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            final card = cards[index];
                            return _SearchCardItem(card: card);
                          },
                        ),
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: $message'),
                        const SizedBox(height: Dimensions.md),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<CollectionCubit>()
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

class _SearchCardItem extends StatelessWidget {
  final entities.Card card;

  const _SearchCardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              card.isLocalImageAvailable
                  ? card.imageUrl
                  : 'assets/images/ygo_placeholder.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              card.name,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
