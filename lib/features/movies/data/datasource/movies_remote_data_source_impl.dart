import 'package:dio/dio.dart';
import 'package:mini_movies/core/constant/api_endpoints.dart';
import 'package:mini_movies/features/movies/data/datasource/movies_remote_data_source.dart';
import 'package:mini_movies/features/movies/data/models/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'movies_remote_data_source_impl.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  factory MoviesRemoteDataSourceImpl(Dio dio, {String baseUrl}) =
      _MoviesRemoteDataSourceImpl;

  @override
  @GET(ApiEndpoints.nowPlaying)
  Future<MovieResponse> getNowPlayingMovies(
    @Query('page') int page,
  );
}
