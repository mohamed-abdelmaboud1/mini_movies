import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_movies/core/cubits/theme_cubit.dart';
import 'package:mini_movies/main.dart';

class IconToggle extends StatelessWidget {
  const IconToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: IconButton(
        icon: Icon(
          context.watch<ThemeCubit>().state == ThemeMode.dark
              ? Icons.light_mode
              : Icons.dark_mode,
          size: 28,
        ),
        onPressed: () {
          context.read<ThemeCubit>().toggleTheme();
        },
      ),
    );
  }
}

class IconToggle2 extends ConsumerWidget {
  const IconToggle2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: IconButton(
        icon: Icon(
          ref.watch(themeProvider) == ThemeMode.dark
              ? Icons.light_mode
              : Icons.dark_mode,
          size: 28,
        ),
        onPressed: () {
          print('🔆 Toggling theme Using Riverpod');
          ref
              .read(themeProvider.notifier)
              .update(
                (state) =>
                    state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
              );
        },
      ),
    );
  }
}
