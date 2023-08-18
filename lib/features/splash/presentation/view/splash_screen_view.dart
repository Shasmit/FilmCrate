import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/splash_viewmodel.dart';

class SplashScreenView extends ConsumerStatefulWidget {
  const SplashScreenView({super.key});

  @override
  ConsumerState<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends ConsumerState<SplashScreenView> {
  @override
  void initState() {
    // Wait for 2 seconds and then navigate
    Future.delayed(const Duration(seconds: 2), () {
      ref.read(splashViewModelProvider.notifier).init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: isTablet
          ? const Image(
              image: AssetImage('images/backgrounds/filmcratesplashtab.png'),
              fit: BoxFit.cover,
            )
          : const Image(
              image: AssetImage('images/backgrounds/filmcratesplash.png'),
              fit: BoxFit.cover,
            ),
    );
  }
}
