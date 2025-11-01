import 'package:dartz/dartz.dart';
import 'package:mini_movies/core/errors/dio_error_handler.dart';
import 'package:mini_movies/core/errors/failure.dart';
import 'package:mini_movies/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:mini_movies/features/movies/data/models/movie_model.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

abstract class MovieRepo {
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies(int page);
}

class MovieRepoImpl implements MovieRepo {
  final MoviesRemoteDataSource homeRemoteDataSource;
  final DioErrorHandler dioErrorHandler;
  MovieRepoImpl({
    required this.homeRemoteDataSource,
    required this.dioErrorHandler,
  });

  @override
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies(
    int page,
  ) async {
    try {
      final response = await homeRemoteDataSource.getNowPlayingMovies(page);
      return Right(response.results);
    } catch (e) {
      // await Sentry.captureException(e);
      return Left(dioErrorHandler.handle(e));
    }
  }
}
