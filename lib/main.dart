import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mini_movies/core/cache/hive_service.dart';
import 'package:mini_movies/core/cubits/theme_cubit.dart';
import 'package:mini_movies/core/di/service_locator.dart';
import 'package:mini_movies/core/theme/app_theme.dart';
import 'package:mini_movies/features/movies/presentation/screens/movies_list_screen.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await MovieHiveService.moviesBox;
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  // await SentryFlutter.init((options) {
  //   options.dsn =
  //       'https://182e78e3dea72e9ad636cb28dd9dd26e@o4510250209509376.ingest.us.sentry.io/4510250211344384';
  //   options.sendDefaultPii = true;
  //   options.tracesSampleRate = 1.0;
  //   options.profilesSampleRate = 1.0;
  // }, appRunner: () => runApp(SentryWidget(child: const MyApp())));
  // // TODO: Remove this line after sending the first sample event to sentry.
  // await Sentry.captureException(StateError('This is a sample exception.'));
  runApp(const MyApp2());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ThemeCubit(), child: const MyAppView());
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: !kReleaseMode && true,

      builder: (context) => BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            title: 'Mini Movies',
            builder: DevicePreview.appBuilder,
            scrollBehavior: CustomScrollBehavior(),
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            home: const MoviesListScreen(),
          );
        },
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: const MyAppView2());
  }
}

class MyAppView2 extends ConsumerWidget {
  const MyAppView2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DevicePreview(
      enabled: !kReleaseMode && true,

      builder: (context) => MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        title: 'Mini Movies',
        builder: DevicePreview.appBuilder,
        scrollBehavior: CustomScrollBehavior(),
        themeMode: ref.watch(themeProvider),
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const MoviesListScreen(),
      ),
    );
  }
}

final themeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.light;
});

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
  };
}
