import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mini_movies/core/cubits/theme_cubit.dart';
import 'package:mini_movies/core/di/service_locator.dart';
import 'package:mini_movies/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:mini_movies/features/movies/presentation/widgets/icon_toggle.dart';
import 'package:mini_movies/features/movies/presentation/widgets/home_body.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MoviesCubit>()..fetchNowPlayingMovies(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.movie, size: 28),
              const Gap(8),
              const Text(
                'Movies',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [IconToggle2()],
        ),
        body: HomeBody(),
      ),
    );
  }
}
