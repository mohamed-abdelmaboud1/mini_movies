import 'package:mini_movies/features/movies/data/models/movie_response.dart';

abstract class MoviesRemoteDataSource {
  Future<MovieResponse> getNowPlayingMovies(int page);
}
