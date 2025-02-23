import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/router/app_router.dart';
import 'package:ygo_collector/src/core/theme/app_theme.dart';
import 'src/core/di/injection_container.dart' as di;

import 'package:ygo_collector/src/features/search/domain/repositories/search_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await di.initializeDependencies();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SearchRepository>(
          create: (context) => di.getIt<SearchRepository>(),
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
