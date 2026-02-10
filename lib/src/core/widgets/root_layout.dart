import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bulk_box/src/core/widgets/sync_pill.dart';
import 'package:bulk_box/src/features/home/presentation/widgets/home_nav_bar.dart';

class RootLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RootLayout({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            right: 0,
            child: const Center(child: SyncPill()),
          ),
        ],
      ),
      bottomNavigationBar: HomeNavBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index);
        },
      ),
    );
  }
}
