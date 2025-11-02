import 'package:hive_ce_flutter/adapters.dart';
import 'package:mini_movies/core/cache/hive_registrar.g.dart';
import 'package:mini_movies/core/constant/hive_keys.dart';
import 'package:mini_movies/features/movies/data/models/movie_hive_model.dart';
import 'package:mini_movies/features/movies/data/models/movie_response.dart';

class MovieHiveService {
  static Box<MovieHiveModel>? _box;

  static Future<Box<MovieHiveModel>> get moviesBox async {
    if (_box != null) return _box!;
    _box = await initBox();
    return _box!;
  }
  // Failed to cache now playing movies: HiveError: There is already a TypeAdapter for typeId 0.
  /*

This file automatically registers all adapters when you call:

Hive.registerAdapters();

So, if you also manually call:

Hive.registerAdapter(MovieHiveModelAdapter());

  */

  static Future<Box<MovieHiveModel>> initBox() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
    return await Hive.openBox<MovieHiveModel>(HiveKeys.moviesBoxKey);
  }

  static Future<void> close() async {
    if (_box != null) {
      await _box!.close();
      _box = null;
    }
  }

  /// Listener for real-time updates
  static Stream<BoxEvent> listenable() {
    return Hive.box<MovieHiveModel>(HiveKeys.moviesBoxKey).watch();
  }

  //cacheNowPlayingMovies
  Future<void> cacheNowPlayingMovies(MovieResponse movieResponse) async {
    try {
      final box = await moviesBox;
      for (var movie in movieResponse.results) {
        final hiveModel = MovieHiveModel.fromMovieModel(movie);
        await box.put(movie.id.toString(), hiveModel);
      }
    } catch (e, st) {
      // Log and rethrow so caller can handle the failure if needed
      print('Failed to cache now playing movies: $e\n$st');
      rethrow;
    }
  }

  // getCachedNowPlayingMovies
  Future<MovieResponse?> getCachedNowPlayingMovies() async {
    final box = await moviesBox;
    if (box.isEmpty) return null;

    final movies = box.values
        .map((hiveModel) => hiveModel.toMovieModel())
        .toList();

    return MovieResponse(
      page: 1,
      results: movies,
      totalPages: 1,
      totalResults: movies.length,
    );
  }
  // ---------- CRUD OPERATIONS ----------

  /// Add movie with a custom key (e.g., movie.id.toString()).
  Future<void> addMovieWithKey(MovieHiveModel movie, String key) async {
    await _box?.put(key, movie);
  }

  /// Read movie using [key].
  MovieHiveModel? readMovieWithKey(String key) {
    return _box?.get(key);
  }

  /// Delete movie by [key].
  Future<void> deleteMovieWithKey(String key) async {
    await _box?.delete(key);
  }

  /// Update existing movie by [key].
  Future<void> updateMovieWithKey(MovieHiveModel movie, String key) async {
    await _box?.put(key, movie);
  }

  /// Add movie (auto-increment key).
  Future<void> addMovie(MovieHiveModel movie) async {
    await _box?.add(movie);
  }

  /// Get movie by index.
  Future<MovieHiveModel?> getMovieAt(int index) async {
    final box = await moviesBox;
    return box.getAt(index);
  }

  /// Delete movie by index.
  Future<void> deleteMovieAt(int index) async {
    final box = await moviesBox;
    await box.deleteAt(index);
  }

  /// Get all saved movies.
  Future<List<MovieHiveModel>> getAllMovies() async {
    final box = await moviesBox;
    return box.values.toList();
  }

  /// Delete all movies.
  Future<void> clearAllMovies() async {
    final box = await moviesBox;
    await box.clear();
  }

  /// Check if movie exists by [key].
  Future<bool> movieExists(String key) async {
    final box = await moviesBox;
    return box.containsKey(key);
  }
}
