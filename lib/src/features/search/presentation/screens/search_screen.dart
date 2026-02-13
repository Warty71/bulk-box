import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bulk_box/src/core/constants/dimensions.dart';
import 'package:bulk_box/src/core/widgets/debouncer.dart';
import 'package:bulk_box/src/core/widgets/app_search_bar.dart';
import 'package:bulk_box/src/core/database/app_database.dart' as db;
import 'package:bulk_box/src/core/di/injection_container.dart' as di;

import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_state.dart';
import 'package:bulk_box/src/features/ygo_cards/presentation/screens/card_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<SearchCubit>(),
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
        title: Text(
          'Search Cards',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          /// 🔍 SEARCH BAR (standardized)
          Padding(
            padding: const EdgeInsets.all(Dimensions.md),
            child: AppSearchBar(
              controller: _searchController,
              hintText: 'Search by card name...',
              onChanged: (query) {
                _debounce.run(() {
                  context.read<SearchCubit>().searchCards(query);
                });
              },
              onClear: () {
                context.read<SearchCubit>().searchCards('');
              },
            ),
          ),

          /// 📦 RESULTS
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
                                    ?.copyWith(color: Colors.grey),
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

class _SearchCardItem extends StatelessWidget {
  final db.Card card;

  const _SearchCardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: context.read<SearchCubit>(),
                child: CardDetailsScreen(card: card),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<String>(
                future: context.read<SearchCubit>().getCardImagePath(card.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return Image.asset(
                      'assets/images/ygo_placeholder.jpg',
                      fit: BoxFit.cover,
                    );
                  }

                  return Image.file(
                    File(snapshot.data!),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Image.asset(
                        'assets/images/ygo_placeholder.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                card.name,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
