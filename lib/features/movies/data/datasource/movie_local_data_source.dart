import 'package:mini_movies/core/cache/hive_service.dart';
import 'package:mini_movies/features/movies/data/models/movie_response.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheNowPlayingMovies(MovieResponse movieResponse);
  Future<MovieResponse?> getCachedNowPlayingMovies();
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  final MovieHiveService hiveService;

  MovieLocalDataSourceImpl(this.hiveService);

  @override
  Future<void> cacheNowPlayingMovies(MovieResponse movieResponse) async {
    await hiveService.cacheNowPlayingMovies(movieResponse);
  }

  @override
  Future<MovieResponse?> getCachedNowPlayingMovies() async {
    return await hiveService.getCachedNowPlayingMovies();
  }
}
