import 'package:filmcrate/config/constants/app_color_theme.dart';
import 'package:filmcrate/core/common/provider/network_connection.dart';
import 'package:filmcrate/features/movies/presentation/viewmodel/movie_view_model.dart';
import 'package:filmcrate/features/movies/presentation/widget/movie_content.dart';
import 'package:filmcrate/features/movies/presentation/widget/popular_movies.dart';
import 'package:filmcrate/features/movies/presentation/widget/trending_movie_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../profile/presentation/viewmodel/profile_view_model.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Function to reload the data when the user triggers a refresh.
  Future<void> _handleRefresh() async {
    // Implement the logic to reload the data here.
    ref.watch(profileViewModelProvider.notifier).getUserProfile();
  }

  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        ref.watch(profileViewModelProvider.notifier).getUserProfile();
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 7.5,
    );
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    var movieState = ref.watch(movieViewModelProvider);
    var profileState = ref.watch(profileViewModelProvider);

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    Widget texts(String title) {
      return Padding(
        padding: isTablet
            ? const EdgeInsets.fromLTRB(20.0, 0, 0, 10)
            : const EdgeInsets.fromLTRB(10.0, 0, 0, 10),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Dongle',
            fontWeight: FontWeight.w500,
            fontSize: isTablet ? 45.0 : 35.0,
          ),
        ),
      );
    }

    if (movieState.isLoading || profileState.isLoading) {
      return Scaffold(
        body: Center(
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: const AlwaysStoppedAnimation(0.0),
                curve: Curves.linear,
              ),
            ),
            child: CircularProgressIndicator(
              color: AppColors.bodyColors,
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.appbarColors,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appbarColors,
        toolbarHeight: isTablet ? 110 : 90.0,
        shadowColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 15, 10),
          child: Text(
            'MOVIE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: isTablet ? 45 : 38,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: isTablet
                ? const EdgeInsets.all(13.0)
                : const EdgeInsets.all(15.0),
            child: CircleAvatar(
              radius: isTablet ? 45.0 : 30.0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              child: ClipOval(
                child: FutureBuilder<bool>(
                  future: checkConnectivity(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final isNetworkConnected = snapshot.data ?? false;
                      final hasProfileImage = profileState.user.isNotEmpty &&
                          profileState.user[0].image != null;

                      if (!isNetworkConnected || !hasProfileImage) {
                        return Image.asset(
                          'images/backgrounds/saitama.jpg',
                          fit: BoxFit.cover,
                          width: isTablet ? 80.0 : 50.0,
                          height: isTablet ? 80.0 : 50.0,
                        );
                      } else {
                        return Image.network(
                          '${ApiEndpoints.baseUrl}/uploads/${profileState.user[0].image}',
                          fit: BoxFit.cover,
                          width: isTablet ? 65.0 : 50.0,
                          height: isTablet ? 65.0 : 50.0,
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: ListView(
            children: <Widget>[
              texts("Top rated IMDb movies"),
              TopRatedMovies(movieList: movieState.movies),
              texts("Trending Movies"),
              TrendingMovies(trendingMovies: movieState.trendingMovies),
              texts("Popular Movies"),
              PopularMovies(popularMovies: movieState.popularMovies),
              // movies3(movieState.movies),
            ],
          ),
        ),
      ),
    );
  }
}
