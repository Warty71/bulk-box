import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygo_collector/src/core/di/injection_container.dart';
import 'package:ygo_collector/src/core/widgets/root_layout.dart';
import 'package:ygo_collector/src/features/home/presentation/cubit/latest_sets_cubit.dart';
import 'package:ygo_collector/src/features/home/presentation/screens/home_screen.dart';
import 'package:ygo_collector/src/features/collection/presentation/screens/collection_screen.dart';
import 'package:ygo_collector/src/features/search/presentation/screens/search_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return RootLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<LatestSetsCubit>(),
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/collection',
                builder: (context, state) => const CollectionScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
