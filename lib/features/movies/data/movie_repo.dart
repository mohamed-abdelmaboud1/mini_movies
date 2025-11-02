import 'package:dartz/dartz.dart';
import 'package:mini_movies/core/errors/dio_error_handler.dart';
import 'package:mini_movies/core/errors/failure.dart';
import 'package:mini_movies/core/helper/has_network.dart';
import 'package:mini_movies/features/movies/data/datasource/movie_local_data_source.dart';
import 'package:mini_movies/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:mini_movies/features/movies/data/models/movie_model.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

abstract class MovieRepo {
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies(int page);
}

class MovieRepoImpl implements MovieRepo {
  final MoviesRemoteDataSource homeRemoteDataSource;
  final MovieLocalDataSource localDataSource;
  final DioErrorHandler dioErrorHandler;
  MovieRepoImpl({
    required this.homeRemoteDataSource,
    required this.localDataSource,
    required this.dioErrorHandler,
  });

  @override
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies(
    int page,
  ) async {
    try {
      if (await InternetConnectionService.isConnected()) {
        final response = await homeRemoteDataSource.getNowPlayingMovies(page);
        await localDataSource.cacheNowPlayingMovies(response);
        
        return Right(response.results);
      } else {
        final cachedResponse = await localDataSource
            .getCachedNowPlayingMovies();
        return Right(cachedResponse?.results ?? []);
      }
    } catch (e) {
      // await Sentry.captureException(e);
      return Left(dioErrorHandler.handle(e));
    }
  }
}
