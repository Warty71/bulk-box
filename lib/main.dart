import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ygo_collector/src/core/ygo_cards/data/datasources/local/card_local_datasource.dart';
import 'package:ygo_collector/src/core/ygo_cards/data/datasources/local/image_local_datasource.dart';
import 'package:ygo_collector/src/core/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:ygo_collector/src/core/router/app_router.dart';
import 'package:ygo_collector/src/core/theme/app_theme.dart';

import 'package:ygo_collector/src/features/search/domain/repositories/search_repository.dart';
import 'package:ygo_collector/src/features/search/data/repositories/search_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final apiDatasource = YGOProApiDatasource();
  final imageLocalDatasource = ImageLocalDatasource();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SearchRepository>(
          create: (context) => SearchRepositoryImpl(
            apiDatasource,
            imageLocalDatasource,
            CardLocalDatasource(prefs),
          ),
        ),
      ],
      child: const MyApp(),
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
