import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mini_movies/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:mini_movies/features/movies/presentation/widgets/movie_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MoviesLoaded) {
          final movies = state.movies;
          //cubit
          final cubit = context.read<MoviesCubit>();
          final hasMore = cubit.hasMore;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<MoviesCubit>().fetchNowPlayingMovies();
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                // Use ScrollUpdateNotification for smoother detection
                if (notification is ScrollUpdateNotification) {
                  final maxScroll = notification.metrics.maxScrollExtent;
                  final currentScroll = notification.metrics.pixels;

                  if (currentScroll >= maxScroll &&
                      hasMore &&
                      !cubit.isLoading) {
                    print('🔽 Reached threshold, loading more...');
                    context.read<MoviesCubit>().fetchNowPlayingMovies(
                      isLoadMore: true,
                    );
                  }
                }
                return false;
              },
              child: ListView.separated(
                itemCount: movies.length + (cubit.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == movies.length) {
                    // Show loader at bottom
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    );
                  }
                  final movie = movies[index];

                  return MovieCard(movie: movie);
                },
                separatorBuilder: (context, index) => const Gap(16),
              ),
            ),
          );
        } else if (state is MoviesError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        } else {
          return const Center(
            child: Text('No movies available', style: TextStyle(fontSize: 16)),
          );
        }
      },
    );
  }
}
