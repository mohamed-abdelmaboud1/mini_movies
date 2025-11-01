import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  const MovieModel({
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

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  final int id;
  final String overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  final String title;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}



// import 'package:hive/hive.dart';

// part 'movie_hive_model.g.dart';

// @HiveType(typeId: 1)
// class MovieHiveModel extends HiveObject {
//   @HiveField(0)
//   final String? backdropPath;

//   @HiveField(1)
//   final List<int> genreIds;

//   @HiveField(2)
//   final int id;

//   @HiveField(3)
//   final String overview;

//   @HiveField(4)
//   final String? posterPath;

//   @HiveField(5)
//   final String? releaseDate;

//   @HiveField(6)
//   final String title;

//   @HiveField(7)
//   final double voteAverage;

//   @HiveField(8)
//   final int voteCount;

//   MovieHiveModel({
//     required this.backdropPath,
//     required this.genreIds,
//     required this.id,
//     required this.overview,
//     required this.posterPath,
//     required this.releaseDate,
//     required this.title,
//     required this.voteAverage,
//     required this.voteCount,
//   });

//   /// Conversion from API model to Hive model
//   factory MovieHiveModel.fromMovieModel(MovieModel model) {
//     return MovieHiveModel(
//       backdropPath: model.backdropPath,
//       genreIds: model.genreIds,
//       id: model.id,
//       overview: model.overview,
//       posterPath: model.posterPath,
//       releaseDate: model.releaseDate,
//       title: model.title,
//       voteAverage: model.voteAverage,
//       voteCount: model.voteCount,
//     );
//   }

//   /// Conversion from Hive model back to API model
//   MovieModel toMovieModel() {
//     return MovieModel(
//       backdropPath: backdropPath,
//       genreIds: genreIds,
//       id: id,
//       overview: overview,
//       posterPath: posterPath,
//       releaseDate: releaseDate,
//       title: title,
//       voteAverage: voteAverage,
//       voteCount: voteCount,
//     );
//   }
// }
