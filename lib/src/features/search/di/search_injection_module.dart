import 'package:get_it/get_it.dart';
import '../domain/repositories/search_repository.dart';
import '../data/repositories/search_repository_impl.dart';
import '../presentation/cubit/search_cubit.dart';

void initSearchModule(GetIt getIt) {
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
