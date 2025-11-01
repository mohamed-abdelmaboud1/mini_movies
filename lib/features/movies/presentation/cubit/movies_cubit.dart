// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_movies/features/movies/data/models/movie_model.dart';
import 'package:mini_movies/features/movies/data/movie_repo.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.movieRepo) : super(MoviesInitial());
  final MovieRepo movieRepo;
  int page = 1;
  List<MovieModel> movies = [];
  bool hasMore = true;
  bool isLoading = false;

  Future<void> fetchNowPlayingMovies({bool isLoadMore = false}) async {

    if (isLoading) {
      print('⚠️ Already loading, skipping...');
      return;
    }

    if (!hasMore && isLoadMore) {
      print('⚠️ No more data to load');
      return;
    }

    if (!isLoadMore) {
      movies = [];
      page = 1;
      hasMore = true;
      emit(
        MoviesLoading(),
      ); 
      print('🔄 Refreshing movies list page: $page');
    } else {
      // Emit loading more state to show bottom loader
      emit(MoviesLoaded(movies: movies, isLoadingMore: true));
    }
    isLoading = true;

    final result = await movieRepo.getNowPlayingMovies(page);

    result.fold(
      (failure) {
        isLoading = false; // Reset loading state on error
        emit(MoviesError(message: failure.message));
      },
      (newMovies) {
        print('Received ${newMovies.length} movies');
        if (newMovies.isEmpty) {
          hasMore = false;
          print('No more movies to load');
        } else {
          page++; // Increment page only if data is received
        }
        movies.addAll(newMovies);
        isLoading = false;
        print(
          '📊 Total movies: ${movies.length}, Page: $page, hasMore: $hasMore',
        );
        emit(MoviesLoaded(movies: movies, isLoadingMore: false));
      },
    );
  }
}
