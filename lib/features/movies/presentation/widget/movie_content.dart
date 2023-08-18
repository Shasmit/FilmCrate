import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:filmcrate/features/movies/presentation/viewmodel/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/network_connection.dart';

class TopRatedMovies extends ConsumerWidget {
  final List<TopRatedMovieEntity> movieList;

  const TopRatedMovies({super.key, required this.movieList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    // Obtain the MovieViewModel instance

    return SizedBox(
      height: isTablet ? screenSize.height * 0.25 : 180.0,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String imagePath = movieList[index].poster_path!;
          return Column(
            children: [
              FutureBuilder<bool>(
                  future: checkConnectivity(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final isNetworkConnected = snapshot.data ?? false;

                      return GestureDetector(
                        onTap: () {
                          if (isNetworkConnected) {
                            final movieId = movieList[index].id;
                            ref
                                .watch(movieViewModelProvider.notifier)
                                .getMovieDetails(movieId!);
                            Navigator.pushNamed(
                              context,
                              AppRoute.movieRoute,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('No Internet Connection'),
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
                        child: Container(
                          height: isTablet ? screenSize.height * 0.15 : 110.0,
                          width: isTablet ? screenSize.height * 0.15 : 120.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(isTablet ? 30.0 : 25.0),
                            border: Border.all(color: Colors.black),
                          ),
                          child: FutureBuilder<bool>(
                            future: checkConnectivity(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                final isNetworkConnected =
                                    snapshot.data ?? false;
                                final imageWidget = isNetworkConnected
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            isTablet ? 30.0 : 25.0),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500$imagePath',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            isTablet ? 30.0 : 25.0),
                                        child: Image.asset(
                                          'images/backgrounds/dino.png',
                                          fit: BoxFit.cover,
                                        ),
                                      );

                                return imageWidget;
                              }
                            },
                          ),
                        ),
                      );
                    }
                  }),
              SizedBox(height: isTablet ? 5.0 : 10.0),
              SizedBox(
                width: isTablet ? 200.0 : 135.0,
                child: Text(
                  movieList[index].title!,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: isTablet ? 18.0 : 12.0,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 5.0),
        itemCount: movieList.length,
      ),
    );
  }
}
