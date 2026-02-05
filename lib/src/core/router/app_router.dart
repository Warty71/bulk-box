import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bulk_box/src/core/di/injection_container.dart';
import 'package:bulk_box/src/core/widgets/root_layout.dart';
import 'package:bulk_box/src/features/home/presentation/cubit/latest_sets_cubit.dart';
import 'package:bulk_box/src/features/home/presentation/screens/home_screen.dart';
import 'package:bulk_box/src/features/collection/presentation/screens/collection_screen.dart';
import 'package:bulk_box/src/features/search/presentation/screens/search_screen.dart';

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
                routes: [
                  GoRoute(
                    path: 'box/:boxId',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: CollectionScreen(
                        boxId: state.pathParameters['boxId'] == 'unboxed'
                            ? null
                            : int.tryParse(
                                state.pathParameters['boxId'] ?? '',
                              ),
                        filterUnboxed:
                            state.pathParameters['boxId'] == 'unboxed',
                        boxName: state.uri.queryParameters['name'],
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.05, 0),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          )),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ],
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
