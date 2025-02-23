import 'package:flutter/material.dart';
import 'package:ygo_collector/src/core/router/app_router.dart';
import 'package:ygo_collector/src/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
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
