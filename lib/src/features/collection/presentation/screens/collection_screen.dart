import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/di/injection_container.dart' as di;
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:ygo_collector/src/features/collection/presentation/screens/collection_view.dart';
import 'package:ygo_collector/src/features/search/presentation/cubit/search_cubit.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.getIt<CollectionCubit>()..loadCollectionItems(),
        ),
        BlocProvider(
          create: (context) => di.getIt<SearchCubit>(),
        ),
      ],
      child: const CollectionView(),
    );
  }
}
