import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ygo_collector/src/features/collection/data/datasources/local/card_local_datasource.dart';
import 'package:ygo_collector/src/features/collection/data/datasources/local/image_local_datasource.dart';
import 'package:ygo_collector/src/features/collection/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:ygo_collector/src/features/collection/data/repositories/card_repository_impl.dart';
import 'package:ygo_collector/src/features/collection/domain/repositories/card_repository.dart';
import 'package:ygo_collector/src/core/router/app_router.dart';
import 'package:ygo_collector/src/core/theme/app_theme.dart';

import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CardRepository>(
          create: (context) => CardRepositoryImpl(
            YGOProApiDatasource(),
            ImageLocalDatasource(),
            CardLocalDatasource(prefs),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => CollectionCubit(context.read<CardRepository>()),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'YGO Collector',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
