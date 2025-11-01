import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mini_movies/core/constant/keys.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final isDark = json[Keys.isDarkTheme] as bool?;
    return (isDark ?? false) ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {Keys.isDarkTheme: state == ThemeMode.dark};
  }
}
