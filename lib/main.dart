import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bulk_box/src/core/router/app_router.dart';
import 'package:bulk_box/src/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:bulk_box/src/core/theme/app_theme.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';
import 'firebase_options.dart';
import 'src/core/di/injection_container.dart' as di;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Configure Crashlytics
    // Pass all uncaught Flutter framework errors to Crashlytics
    FlutterError.onError =
        FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Disable Crashlytics collection in debug mode
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);

    // Initialize HydratedBloc storage for persisting state
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(
        (await getApplicationDocumentsDirectory()).path,
      ),
    );

    // Initialize dependencies
    await di.initializeDependencies();

    runApp(const MyApp());
  }, (error, stack) {
    // Pass all uncaught asynchronous errors to Crashlytics
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<SearchCubit>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<SettingsCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Bulk Box',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
