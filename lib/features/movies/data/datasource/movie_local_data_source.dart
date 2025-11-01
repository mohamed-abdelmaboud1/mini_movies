import 'package:mini_movies/features/movies/data/models/movie_response.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheNowPlayingMovies(MovieResponse movieResponse);
  Future<MovieResponse?> getCachedNowPlayingMovies();
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  @override
  Future<void> cacheNowPlayingMovies(MovieResponse movieResponse) {
    // TODO: implement cacheNowPlayingMovies
    throw UnimplementedError();
  }

  @override
  Future<MovieResponse?> getCachedNowPlayingMovies() {
    // TODO: implement getCachedNowPlayingMovies
    throw UnimplementedError();
  }
}
