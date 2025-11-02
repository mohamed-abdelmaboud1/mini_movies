import 'package:mini_movies/features/movies/data/models/movie_model.dart';


class MovieHiveModel {
  final String? backdropPath;


  final List<int> genreIds;

  final int id;


  final String overview;


  final String? posterPath;

  final String? releaseDate;

  final String title;


  final double voteAverage;


  final int voteCount;

  MovieHiveModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  /// Conversion from API model to Hive model
  factory MovieHiveModel.fromMovieModel(MovieModel model) {
    return MovieHiveModel(
      backdropPath: model.backdropPath,
      genreIds: model.genreIds,
      id: model.id,
      overview: model.overview,
      posterPath: model.posterPath,
      releaseDate: model.releaseDate,
      title: model.title,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
    );
  }

  /// Conversion from Hive model back to API model
  MovieModel toMovieModel() {
    return MovieModel(
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
