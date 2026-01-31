import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ygo_collector/src/core/database/app_database.dart';
import 'package:ygo_collector/src/features/sorting/presentation/cubits/sort_cubit.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/datasources/local/card_local_datasource.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/datasources/local/image_local_datasource.dart';
import 'package:ygo_collector/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:ygo_collector/src/features/search/data/repositories/search_repository_impl.dart';
import 'package:ygo_collector/src/features/search/domain/repositories/search_repository.dart';
import 'package:ygo_collector/src/features/search/presentation/cubit/search_cubit.dart';
import 'package:ygo_collector/src/features/collection/data/datasources/collection_local_datasource.dart';
import 'package:ygo_collector/src/features/collection/data/repositories/collection_repository_impl.dart';
import 'package:ygo_collector/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:ygo_collector/src/features/collection/presentation/cubit/collection_cubit.dart';

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
    () => CardLocalDatasource(getIt()),
  );
}

Future<void> _initializeFeatures() async {
  // Search Feature
  _initializeSearchFeature();

  // Collection Feature
  _initializeCollectionFeature();

  // Sorting Feature
  _initializeSortingFeature();
}

void _initializeSearchFeature() {
  // Repository
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      getIt(), // YGOProApiDatasource
      getIt(), // ImageLocalDatasource
      getIt(), // CardLocalDatasource
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
    () => CollectionCubit(getIt(), getIt()),
  );
}

void _initializeSortingFeature() {
  // Cubit
  getIt.registerLazySingleton(
    () => SortCubit(),
  );
}
