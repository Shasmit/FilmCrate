import 'package:filmcrate/config/constants/app_color_theme.dart';
import 'package:filmcrate/config/constants/custom_icon.dart';
import 'package:filmcrate/config/router/app_route.dart';
import 'package:filmcrate/features/about_movie/presentation/viewmodel/all_review_view_model.dart';
import 'package:filmcrate/features/about_movie/presentation/widget/cast_view.dart';
import 'package:filmcrate/features/about_movie/presentation/widget/category_details.dart';
import 'package:filmcrate/features/about_movie/presentation/widget/genre_details.dart';
import 'package:filmcrate/features/about_movie/presentation/widget/headings.dart';
import 'package:filmcrate/features/about_movie/presentation/widget/reviews.dart';
import 'package:filmcrate/features/about_movie/presentation/widget/sliverappbars.dart';
import 'package:filmcrate/features/movies/presentation/viewmodel/movie_view_model.dart';
import 'package:filmcrate/features/watchlist/presentation/viewmodel/watchlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';

class AboutMovies extends ConsumerStatefulWidget {
  const AboutMovies({Key? key}) : super(key: key);

  @override
  _AboutMoviesState createState() => _AboutMoviesState();
}

class _AboutMoviesState extends ConsumerState<AboutMovies> {
  var gap = const SizedBox(
    height: 15,
  );
  bool isShowAll = false;

  @override
  Widget build(BuildContext context) {
    final allMovieState = ref.watch(movieViewModelProvider);

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    // Check if the movie details are still loading
    if (allMovieState.isLoading) {
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
    int similarMovieIndex = 0;
    while (allMovieState
            .allMovies[0].similarMovies![similarMovieIndex].posterPath ==
        null) {
      similarMovieIndex++;
      if (similarMovieIndex >=
          allMovieState.allMovies[0].similarMovies!.length) {
        similarMovieIndex = 0;
        break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBars(
            allMovieState.allMovies[0].movie!.backdropPath == null
                ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'
                : 'https://image.tmdb.org/t/p/original/${allMovieState.allMovies[0].movie!.backdropPath}',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Headings(
                        title: allMovieState.allMovies[0].movie!.title,
                        width: isTablet ? 500 : 300,
                      ),
                      IconButton(
                        onPressed: () async {
                          final movieId = allMovieState.allMovies[0].id!;

                          if (allMovieState.allMovies[0].isWatchListed! ==
                              true) {
                            // If the movie is already bookmarked, delete it from the watchlist
                            await ref
                                .watch(watchListViewModelProvider.notifier)
                                .deleteWatchlist(movieId);
                          } else {
                            // If the movie is not bookmarked, add it to the watchlist
                            await ref
                                .watch(watchListViewModelProvider.notifier)
                                .createWatchlist(movieId);
                          }

                          ref
                              .watch(movieViewModelProvider.notifier)
                              .getMovieDetails(allMovieState.allMovies[0].id!);

                          ref
                              .watch(watchListViewModelProvider.notifier)
                              .getWatchList();
                          // setState(() {
                          //   // Toggle the bookmark icon
                          //   isBookmarkSelected =
                          //       !allMovieState.allMovies[0].isWatchListed!;
                          // });
                        },
                        icon: allMovieState.allMovies[0].isWatchListed! == true
                            ? Icon(
                                Icons.bookmark_added_rounded,
                                size: isTablet ? 40 : 30,
                              )
                            : Icon(
                                Icons.bookmark_rounded,
                                size: isTablet ? 40 : 30,
                                color: Colors.grey,
                              ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CustomIcon.imdb,
                        size: isTablet ? 50 : 35,
                        color: const Color(0xffEDBF17),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          '${allMovieState.allMovies[0].movie!.voteAverage}/10 IMDb',
                          style: TextStyle(
                            fontFamily: 'DOngle',
                            fontSize: isTablet ? 40 : 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  gap,
                  GenreDetails(
                    allMovieList: allMovieState.allMovies,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: Row(
                      children: [
                        CategoryDetials(
                          title: 'release date',
                          value: allMovieState.allMovies[0].movie!.releaseDate,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        CategoryDetials(
                          title: 'Language',
                          value: allMovieState
                              .allMovies[0].movie!.originalLanguage!,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        CategoryDetials(
                          title: 'IMDb ID',
                          value:
                              allMovieState.allMovies[0].movie!.id.toString(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Headings(
                          title: 'Description',
                          width: isTablet ? 500 : 300,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 8, 8),
                          child: Text(
                            allMovieState.allMovies[0].movie!.overview!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 20 : 14,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  gap,
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Headings(
                            title: 'Cast',
                            width: isTablet ? 100 : 60,
                          ),
                          SizedBox(
                            height: isTablet ? 40 : 30,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isShowAll = !isShowAll;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.bodyColors,
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: AppColors.bodyColors,
                                ),
                              ),
                              child: Text(
                                isShowAll ? 'See Less' : 'See More',
                                style: TextStyle(
                                  fontFamily: 'Dongle',
                                  fontSize: isTablet ? 30 : 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CastActors(
                    isShowAll: isShowAll,
                    allMovieList: allMovieState.allMovies,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Headings(
                      title: "Reviews",
                      width: isTablet ? 500 : 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Column(
                      children: [
                        allMovieState.allMovies[0].topReviews!.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allMovieState
                                    .allMovies[0].topReviews!.length,
                                itemBuilder: (context, index) {
                                  final review = allMovieState
                                      .allMovies[0].topReviews![index];
                                  return Column(
                                    children: [
                                      ReviewsView(
                                        assetImage:
                                            '${ApiEndpoints.baseUrl}/uploads/${review.user.image}',
                                        name: review.user.username,
                                        reviewText: review.review,
                                        rating: review.rating,
                                        ref: ref,
                                        likes: review.likes.length.toString(),
                                        likeReview: review.isLiked!,
                                        isUser: review.isUserLoggedIn!,
                                        onEdit: () {
                                          final String reviewId = review.id;
                                          Navigator.pushNamed(
                                            context,
                                            AppRoute.updateReview,
                                            arguments: reviewId,
                                          );

                                          ref
                                              .watch(movieViewModelProvider
                                                  .notifier)
                                              .getMovieDetails(allMovieState
                                                  .allMovies[0].id!);
                                        },
                                        onDelete: () {
                                          ref
                                              .watch(reviewViewModelProvider
                                                  .notifier)
                                              .deleteReview(
                                                  allMovieState
                                                      .allMovies[0].id!,
                                                  review.id);

                                          ref
                                              .watch(movieViewModelProvider
                                                  .notifier)
                                              .getMovieDetails(allMovieState
                                                  .allMovies[0].id!);
                                        },
                                        onLikeReview: (isLiked) {
                                          // Call the likeReview/dislikeReview functions here.
                                          if (isLiked) {
                                            ref
                                                .watch(reviewViewModelProvider
                                                    .notifier)
                                                .likeReview(
                                                    int.parse(review.movieID),
                                                    review.id);
                                          } else {
                                            ref
                                                .watch(reviewViewModelProvider
                                                    .notifier)
                                                .dislikeReview(
                                                    int.parse(review.movieID),
                                                    review.id);
                                          }

                                          ref
                                              .read(movieViewModelProvider
                                                  .notifier)
                                              .getMovieDetails(allMovieState
                                                  .allMovies[0].id!);

                                          ref
                                              .read(reviewViewModelProvider
                                                  .notifier)
                                              .getAllReviews(allMovieState
                                                  .allMovies[0].id!);
                                          // Update the review.isLiked property after performing the like/dislike.
                                        },
                                      ),
                                      gap,
                                    ],
                                  );
                                },
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'No reviews for this movie yet.',
                                  style: TextStyle(
                                    fontSize: isTablet ? 22 : 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                        allMovieState.allMovies[0].topReviews!.isNotEmpty
                            ? TextButton(
                                onPressed: () {
                                  final reviewId =
                                      allMovieState.allMovies[0].id;
                                  ref
                                      .watch(reviewViewModelProvider.notifier)
                                      .getAllReviews(reviewId!);
                                  Navigator.pushNamed(
                                      context, AppRoute.allReviews);
                                },
                                child: Text(
                                  'ALL REVIEWS',
                                  style: TextStyle(
                                    fontSize: isTablet ? 22 : 14,
                                  ),
                                ),
                              )
                            : Container(),
                        allMovieState.allMovies[0].topReviews!.isNotEmpty
                            ? const Divider(
                                color: Colors.black,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Headings(
                          title: 'Similar Movies',
                          width: isTablet ? 500 : 300,
                        ),
                        Row(
                          mainAxisAlignment: isTablet
                              ? MainAxisAlignment.spaceAround
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (allMovieState
                                        .allMovies[0]
                                        .similarMovies![similarMovieIndex + 2]
                                        .posterPath ==
                                    null) {
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
                                } else {
                                  final movieId = allMovieState.allMovies[0]
                                      .similarMovies![similarMovieIndex + 2].id;
                                  ref
                                      .watch(movieViewModelProvider.notifier)
                                      .getMovieDetails(movieId);
                                  Navigator.popAndPushNamed(
                                    context,
                                    AppRoute.movieRoute,
                                  );
                                }
                              },
                              child: SizedBox(
                                height: isTablet ? 300 : 100,
                                width: isTablet ? screenSize.width * 0.3 : 100,
                                child: allMovieState
                                            .allMovies[0]
                                            .similarMovies![
                                                similarMovieIndex + 2]
                                            .posterPath ==
                                        null
                                    ? Image.asset(
                                        'images/backgrounds/noInfo.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://image.tmdb.org/t/p/original/${allMovieState.allMovies[0].similarMovies![similarMovieIndex + 2].posterPath}',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (allMovieState
                                        .allMovies[0]
                                        .similarMovies![similarMovieIndex + 3]
                                        .posterPath ==
                                    null) {
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
                                } else {
                                  final movieId = allMovieState.allMovies[0]
                                      .similarMovies![similarMovieIndex + 3].id;
                                  ref
                                      .watch(movieViewModelProvider.notifier)
                                      .getMovieDetails(movieId);
                                  Navigator.popAndPushNamed(
                                    context,
                                    AppRoute.movieRoute,
                                  );
                                }
                              },
                              child: SizedBox(
                                height: isTablet ? 300 : 100,
                                width: isTablet ? screenSize.width * 0.3 : 100,
                                child: allMovieState
                                            .allMovies[0]
                                            .similarMovies![
                                                similarMovieIndex + 3]
                                            .posterPath ==
                                        null
                                    ? Image.asset(
                                        'images/backgrounds/noInfo.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://image.tmdb.org/t/p/original/${allMovieState.allMovies[0].similarMovies![similarMovieIndex + 3].posterPath}',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (allMovieState
                                        .allMovies[0]
                                        .similarMovies![similarMovieIndex + 4]
                                        .posterPath ==
                                    null) {
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
                                } else {
                                  final movieId = allMovieState.allMovies[0]
                                      .similarMovies![similarMovieIndex + 4].id;
                                  ref
                                      .watch(movieViewModelProvider.notifier)
                                      .getMovieDetails(movieId);
                                  Navigator.popAndPushNamed(
                                    context,
                                    AppRoute.movieRoute,
                                  );
                                }
                              },
                              child: SizedBox(
                                height: isTablet ? 300 : 100,
                                width: isTablet ? screenSize.width * 0.3 : 100,
                                child: allMovieState
                                            .allMovies[0]
                                            .similarMovies![
                                                similarMovieIndex + 4]
                                            .posterPath ==
                                        null
                                    ? Image.asset(
                                        'images/backgrounds/noInfo.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://image.tmdb.org/t/p/original/${allMovieState.allMovies[0].similarMovies![similarMovieIndex + 4].posterPath}',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final movieId = allMovieState.allMovies[0].id;
          ref.read(movieViewModelProvider.notifier).getMovieDetails(movieId!);
          Navigator.pushNamed(context, AppRoute.writeReview);
        },
        backgroundColor: Colors.green,
        heroTag: null,
        foregroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: isTablet ? 30 : 22,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
