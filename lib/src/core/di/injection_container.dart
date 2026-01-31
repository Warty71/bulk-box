import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/settings/settings_cubit.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/local/image_local_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/search/data/repositories/search_repository_impl.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';
import 'package:bulk_box/src/features/collection/data/datasources/collection_local_datasource.dart';
import 'package:bulk_box/src/features/collection/data/repositories/collection_repository_impl.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/home/presentation/cubit/latest_sets_cubit.dart';
import 'package:bulk_box/src/features/ygo_cards/data/repositories/set_list_repository_impl.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/repositories/set_list_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  await _initializeCore();

  // Features
  await _initializeFeatures();
}

Future<void> _initializeCore() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton(prefs);

  // Database
  getIt.registerLazySingleton<AppDatabase>(
    () => AppDatabase(),
  );

  // Datasources
  getIt.registerLazySingleton(
    () => YGOProApiDatasource(),
  );

  getIt.registerLazySingleton(
    () => ImageLocalDatasource(),
  );

  getIt.registerLazySingleton(
    () => CardDao(getIt<AppDatabase>()),
  );
}

Future<void> _initializeFeatures() async {
  // Settings (persisted via hydrated_bloc)
  _initializeSettings();

  // Search Feature
  _initializeSearchFeature();

  // Collection Feature
  _initializeCollectionFeature();

  // Home Feature (latest sets)
  _initializeHomeFeature();
}

void _initializeHomeFeature() {
  getIt.registerLazySingleton<SetListRepository>(
    () => SetListRepositoryImpl(getIt<YGOProApiDatasource>()),
  );

  getIt.registerFactory(
    () => LatestSetsCubit(getIt<SetListRepository>()),
  );
}

void _initializeSearchFeature() {
  // Repository
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      getIt(), // YGOProApiDatasource
      getIt(), // ImageLocalDatasource
      getIt(), // CardDao
    ),
  );

  // Cubit
  getIt.registerFactory(
    () => SearchCubit(getIt()),
  );
}

void _initializeCollectionFeature() {
  // Datasource
  getIt.registerLazySingleton(
    () => CollectionLocalDatasource(getIt<AppDatabase>()),
  );

  // Repository
  getIt.registerLazySingleton<CollectionRepository>(
    () => CollectionRepositoryImpl(getIt()),
  );

  // Cubit
  getIt.registerLazySingleton(
    () => CollectionCubit(getIt()),
  );
}

void _initializeSettings() {
  getIt.registerLazySingleton(
    () => SettingsCubit(),
  );
}
