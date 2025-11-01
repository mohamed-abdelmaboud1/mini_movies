part of 'movies_cubit.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesLoaded extends MoviesState {
  final List<MovieModel> movies;
  final bool isLoadingMore;

  const MoviesLoaded({required this.movies, this.isLoadingMore = false});

  @override
  List<Object> get props => [movies, isLoadingMore];
}

final class MoviesError extends MoviesState {
  final String message;

  const MoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
