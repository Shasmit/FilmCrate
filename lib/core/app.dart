import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../proximity.dart';
import 'common/provider/is_dark_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);

    return ProximityBrightnessControl(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FilmCrate',
        theme: AppThemes.getApplicationTheme(isDarkTheme),
        initialRoute: AppRoute.splashRoute,
        routes: AppRoute.getApplicationRoute(),
      ),
    );
  }
}
