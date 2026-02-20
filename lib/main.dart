import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:bulk_box/src/core/router/app_router.dart';
import 'package:bulk_box/src/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:bulk_box/src/core/theme/app_theme.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';
import 'src/core/di/injection_container.dart' as di;

const _sentryDsn = String.fromEnvironment('SENTRY_DSN');

void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = kReleaseMode ? _sentryDsn : '';
      options.environment = 'production';
      options.tracesSampleRate = 0.2;
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorageDirectory(
          (await getApplicationDocumentsDirectory()).path,
        ),
      );

      await di.initializeDependencies();

      runApp(const MyApp());
    },
  );
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
