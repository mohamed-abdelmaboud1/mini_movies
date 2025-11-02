import 'package:get_it/get_it.dart';
import 'package:mini_movies/core/api/api_interceptors.dart';
import 'package:mini_movies/core/api/dio_module.dart';
import 'package:mini_movies/core/cache/hive_service.dart';
import 'package:mini_movies/core/errors/dio_error_handler.dart';
import 'package:mini_movies/features/movies/data/datasource/movie_local_data_source.dart';
import 'package:mini_movies/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:mini_movies/features/movies/data/datasource/movies_remote_data_source_impl.dart';
import 'package:mini_movies/features/movies/data/movie_repo.dart';
import 'package:mini_movies/features/movies/presentation/cubit/movies_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Core
  getIt.registerLazySingleton<ApiInterceptor>(() => ApiInterceptor());
  getIt.registerLazySingleton<DioModule>(() => DioModule(getIt()));
  getIt.registerLazySingleton<DioErrorHandler>(() => DioErrorHandler());
  getIt.registerLazySingleton<MovieHiveService>(() => MovieHiveService());
  // Data sources
  getIt.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(getIt<DioModule>().dioInstance),
  );
  getIt.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(getIt<MovieHiveService>()),
  );

  // Repositories
  getIt.registerLazySingleton<MovieRepo>(
    () => MovieRepoImpl(
      homeRemoteDataSource: getIt(),
      localDataSource: getIt(),
      dioErrorHandler: getIt(),
    ),
  );
  //cubit
  getIt.registerFactory<MoviesCubit>(() => MoviesCubit(getIt()));
}
