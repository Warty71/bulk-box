import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bulk_box/src/core/database/app_database.dart';
import 'package:bulk_box/src/core/database/box_dao.dart';
import 'package:bulk_box/src/core/database/card_dao.dart';
import 'package:bulk_box/src/core/settings/settings_cubit.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/local/image_local_datasource.dart';
import 'package:bulk_box/src/features/ygo_cards/data/datasources/remote/ygopro_api_datasource.dart';
import 'package:bulk_box/src/features/search/data/repositories/search_repository_impl.dart';
import 'package:bulk_box/src/features/search/domain/repositories/search_repository.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/search_cubit.dart';
import 'package:bulk_box/src/features/search/presentation/cubit/quick_add_cubit.dart';
import 'package:bulk_box/src/features/collection/data/datasources/collection_local_datasource.dart';
import 'package:bulk_box/src/features/collection/data/repositories/box_repository_impl.dart';
import 'package:bulk_box/src/features/collection/data/repositories/collection_repository_impl.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/box_repository.dart';
import 'package:bulk_box/src/features/collection/domain/repositories/collection_repository.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/bulk_move_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/boxes_cubit.dart';
import 'package:bulk_box/src/features/collection/presentation/cubit/collection_cubit.dart';
import 'package:bulk_box/src/features/home/presentation/cubit/latest_sets_cubit.dart';
import 'package:bulk_box/src/features/ygo_cards/data/repositories/image_repository_impl.dart';
import 'package:bulk_box/src/features/ygo_cards/data/repositories/set_list_repository_impl.dart';
import 'package:bulk_box/src/features/ygo_cards/data/services/archetype_backfill_service.dart';
import 'package:bulk_box/src/features/ygo_cards/domain/repositories/image_repository.dart';
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
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Database
  getIt.registerLazySingleton<AppDatabase>(
    () => AppDatabase(),
  );

  // Datasources
  getIt.registerLazySingleton<YGOProApiDatasource>(
    () => YGOProApiDatasource(),
  );

  getIt.registerLazySingleton<ImageLocalDatasource>(
    () => ImageLocalDatasource(),
  );

  getIt.registerLazySingleton<CardDao>(
    () => CardDao(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<BoxDao>(
    () => BoxDao(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<ArchetypeBackfillService>(
    () => ArchetypeBackfillService(
      getIt<YGOProApiDatasource>(),
      getIt<CardDao>(),
      getIt<SharedPreferences>(),
    ),
  );

  getIt.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(
      getIt<ImageLocalDatasource>(),
      getIt<YGOProApiDatasource>(),
      getIt<CardDao>(),
    ),
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

  getIt.registerFactory<LatestSetsCubit>(
    () => LatestSetsCubit(getIt<SetListRepository>()),
  );
}

void _initializeSearchFeature() {
  // Repository
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      getIt<YGOProApiDatasource>(),
      getIt<ImageRepository>(),
      getIt<CardDao>(),
    ),
  );

  // Cubits
  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(getIt<SearchRepository>()),
  );

  getIt.registerFactory<QuickAddCubit>(
    () => QuickAddCubit(
      getIt<CardDao>(),
      getIt<CollectionRepository>(),
    ),
  );
}

void _initializeCollectionFeature() {
  // Datasource
  getIt.registerLazySingleton<CollectionLocalDatasource>(
    () => CollectionLocalDatasource(getIt<AppDatabase>()),
  );

  // Repositories
  getIt.registerLazySingleton<BoxRepository>(
    () => BoxRepositoryImpl(getIt<BoxDao>()),
  );

  getIt.registerLazySingleton<CollectionRepository>(
    () => CollectionRepositoryImpl(getIt<CollectionLocalDatasource>()),
  );

  // Cubits (BoxesCubit singleton so box list/counts refresh after moving cards)
  getIt.registerLazySingleton<BoxesCubit>(
    () => BoxesCubit(getIt<BoxRepository>()),
  );

  // CollectionCubit singleton so collection changes propagate across screens
  // (e.g., search screen can react to collection updates)
  getIt.registerLazySingleton<CollectionCubit>(
    () => CollectionCubit(getIt<CollectionRepository>()),
  );

  getIt.registerFactory<BulkMoveCubit>(
    () => BulkMoveCubit(),
  );
}

void _initializeSettings() {
  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(),
  );
}
