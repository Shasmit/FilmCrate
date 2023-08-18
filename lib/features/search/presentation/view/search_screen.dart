import 'package:filmcrate/config/constants/app_color_theme.dart';
import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/features/movies/presentation/viewmodel/movie_view_model.dart';
import 'package:filmcrate/features/search/presentation/viewmodel/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../../profile/presentation/viewmodel/profile_view_model.dart';
import '../../../watchlist/presentation/viewmodel/watchlist_view_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String searchText = '';
  // List<String> movieName = EveryList().movieNames;
  // List<String> imageName = EveryList().imagePaths;
  List<String> recentSearches = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(watchListViewModelProvider.notifier).getWatchList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    final searchState = ref.watch(searchViewModelProvider);
    final profileState = ref.watch(profileViewModelProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.appbarColors,
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            snap: false,
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            centerTitle: false,
            toolbarHeight: isTablet ? 100 : 90.0,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 15, 10),
              child: Text(
                'SEARCH',
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
                    : const EdgeInsets.all(18.0),
                child: CircleAvatar(
                  radius: isTablet ? 45.0 : 30.0,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  child: ClipOval(
                    child: FutureBuilder<bool>(
                      future: checkConnectivity(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final isNetworkConnected = snapshot.data ?? false;
                          final hasProfileImage =
                              profileState.user.isNotEmpty &&
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
            bottom: AppBar(
              automaticallyImplyLeading: false,
              elevation: 2,
              backgroundColor: AppColors.appbarColors,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.0),
                ),
              ),
              toolbarHeight: 70,
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: isTablet ? 60 : 45,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                        ref
                            .watch(searchViewModelProvider.notifier)
                            .getSearchedMovies(searchText);
                      });
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: isTablet ? 20 : 15.0,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: isTablet ? 30 : 24,
                      ),
                      filled: true,
                      fillColor: AppColors.bodyColors,
                      hintText: 'Search for your heart',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: isTablet ? 20 : 15.0,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 75.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (searchText.isEmpty) {
                    if (recentSearches.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            'Your Searches Will Appear Here',
                            style: TextStyle(
                              fontSize: isTablet ? 25 : 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      );
                    }
                  } else if (index < searchState.movies.length) {
                    final movie = searchState.movies[index];

                    Widget movieWidget;
                    if (movie.posterPath != null) {
                      movieWidget = GestureDetector(
                        onTap: () {
                          final movieid = movie.id;
                          ref
                              .watch(movieViewModelProvider.notifier)
                              .getMovieDetails(movieid!);
                          Navigator.pushNamed(context, AppRoute.movieRoute);
                        },
                        child: ListTile(
                          leading: Container(
                            height: isTablet ? 150 : 100,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(isTablet ? 10.0 : 10.0),
                              border: Border.all(color: Colors.black),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(isTablet ? 10.0 : 10.0),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            movie.title!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 25 : 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      movieWidget = ListTile(
                        leading: Container(
                          height: isTablet ? 150 : 100,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(isTablet ? 30.0 : 10.0),
                            border: Border.all(color: Colors.black),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(isTablet ? 30.0 : 10.0),
                            child: const Image(
                              image:
                                  AssetImage('images/backgrounds/noInfo.png'),
                            ),
                          ),
                        ),
                        title: Text(
                          movie.title!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: isTablet ? 30 : 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'No info on this movie yet!',
                                  style: TextStyle(
                                    fontFamily: 'Dongle',
                                    fontSize: 35.0,
                                  ),
                                ),
                                content: const Text(
                                  'FILMCRATE IS SORRY.',
                                  style: TextStyle(
                                    fontFamily: 'Dongle',
                                    fontSize: 25.0,
                                  ),
                                ),
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
                        },
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child: Container(
                        color: AppColors.bodyColors,
                        height: isTablet ? 150 : 100,
                        child: Center(
                          child: movieWidget,
                        ),
                      ),
                    );
                  } else {
                    return null;
                  }
                  return null;
                },
                childCount: searchText.isEmpty ? 1 : searchState.movies.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
