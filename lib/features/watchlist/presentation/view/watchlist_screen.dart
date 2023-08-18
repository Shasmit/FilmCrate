import 'package:filmcrate/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_color_theme.dart';
import '../../../../config/router/app_route.dart';
import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../../movies/presentation/viewmodel/movie_view_model.dart';
import '../viewmodel/watchlist_view_model.dart';

class WatchListScreen extends ConsumerStatefulWidget {
  const WatchListScreen({super.key});

  @override
  ConsumerState<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends ConsumerState<WatchListScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Function to reload the data when the user triggers a refresh.
  Future<void> _handleRefresh() async {
    // Implement the logic to reload the data here.
    ref.watch(watchListViewModelProvider.notifier).getWatchList();
    ref.watch(profileViewModelProvider.notifier).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final watchListState = ref.watch(watchListViewModelProvider);
    final internetStatus = ref.watch(connectivityStatusProvider);
    final profileState = ref.watch(profileViewModelProvider);

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final orientation = MediaQuery.of(context).orientation;
    final crossAxisCount = orientation == Orientation.portrait ? 3 : 5;
    final mainAxisSpacing = orientation == Orientation.portrait ? 30.0 : 15.0;
    final crossAxisSpacing = orientation == Orientation.portrait ? 15.0 : 10.0;

    if (watchListState.isLoading || profileState.isLoading) {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        toolbarHeight: isTablet ? 110 : 90.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'WATCHLIST',
            style: TextStyle(
              fontSize: isTablet ? 40 : 38,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: isTablet
                ? const EdgeInsets.all(13.0)
                : const EdgeInsets.all(18.0),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: FutureBuilder<bool>(
          future: checkConnectivity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While checking connectivity, show a loading indicator or
              // any other widget to indicate that we are checking.
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // If an error occurred while checking connectivity, handle it here.
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final isNetworkConnected = snapshot.data ?? false;

              if (!isNetworkConnected) {
                // If no internet, show the "No Internet" message.
                return const Center(
                  child: Text('No Internet Connection'),
                );
              } else {
                // If internet is connected, show the ListView.
                return RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _handleRefresh,
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'Your WatchList',
                          style: TextStyle(
                            fontFamily: 'Dongle',
                            fontSize: isTablet ? 45 : 35,
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (watchListState.watchList!.isNotEmpty) ...{
                        Padding(
                          padding: isTablet
                              ? const EdgeInsets.fromLTRB(10, 30, 10, 45)
                              : const EdgeInsets.fromLTRB(10, 20, 10, 45),
                          child: GridView.builder(
                            itemCount: watchListState.watchList!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: mainAxisSpacing,
                              crossAxisSpacing: crossAxisSpacing,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (internetStatus ==
                                      ConnectivityStatus.isConnected) {
                                    final movieId = int.parse(watchListState
                                        .watchList![index].movieId);
                                    ref
                                        .watch(movieViewModelProvider.notifier)
                                        .getMovieDetails(movieId);
                                    Navigator.pushNamed(
                                      context,
                                      AppRoute.movieRoute,
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'No Internet Connection'),
                                          content: const Text(
                                              'Please check your internet connection and try again.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Container(
                                      height: isTablet
                                          ? screenSize.height * 0.15
                                          : 100.0,
                                      width: isTablet
                                          ? screenSize.height * 0.15
                                          : 120.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            isTablet ? 30.0 : 25.0),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            isTablet ? 30.0 : 25.0),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/original/${watchListState.watchList![index].movieDetails.posterPath}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: isTablet ? 200.0 : 135.0,
                                      child: Padding(
                                        padding: isTablet
                                            ? const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0)
                                            : const EdgeInsets.fromLTRB(
                                                0, 3, 0, 0),
                                        child: Text(
                                          watchListState.watchList![index]
                                              .movieDetails.title,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontFamily: 'Dongle',
                                            fontWeight: FontWeight.normal,
                                            fontSize: isTablet ? 38.0 : 20.0,
                                            letterSpacing: 0.5,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      } else ...{
                        Padding(
                          padding: isTablet
                              ? const EdgeInsets.fromLTRB(10, 30, 10, 45)
                              : const EdgeInsets.fromLTRB(10, 20, 10, 45),
                          child: Text(
                            'No movies added to watchlist yet!🍿',
                            style: TextStyle(
                              fontFamily: 'Dongle',
                              fontSize: isTablet ? 22 : 30,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      }
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
