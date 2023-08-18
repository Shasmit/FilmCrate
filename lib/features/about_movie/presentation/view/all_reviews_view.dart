import 'package:filmcrate/features/about_movie/presentation/viewmodel/all_review_view_model.dart';
import 'package:filmcrate/features/about_movie/presentation/widget/reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/router/app_route.dart';
import '../../../movies/presentation/viewmodel/movie_view_model.dart';

class AllReviewsView extends ConsumerStatefulWidget {
  const AllReviewsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllReviewsViewState();
}

class _AllReviewsViewState extends ConsumerState<AllReviewsView> {
  @override
  Widget build(BuildContext context) {
    final reviewState = ref.watch(reviewViewModelProvider);

    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.white,
            floating: true,
            snap: false,
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, AppRoute.movieRoute);
            //     ref
            //         .read(movieViewModelProvider.notifier)
            //         .getMovieDetails(int.parse(reviewState.reviews[0].movieID));
            //   },
            //   icon: const Icon(Icons.arrow_back),
            //   alignment: Alignment.topCenter,
            // ),
            // automaticallyImplyLeading: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < reviewState.reviews.length) {
                    if (reviewState.reviews.isNotEmpty) {
                      final review = reviewState
                          .reviews[index]; // Always use the first review.
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: ReviewsView(
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
                            Navigator.popAndPushNamed(
                              context,
                              AppRoute.updateReview,
                              arguments: reviewId,
                            );
                            ref
                                .watch(movieViewModelProvider.notifier)
                                .getMovieDetails(int.parse(review.movieID));
                          },
                          onDelete: () {
                            ref
                                .watch(reviewViewModelProvider.notifier)
                                .deleteReview(
                                    int.parse(review.movieID), review.id);

                            ref
                                .read(movieViewModelProvider.notifier)
                                .getMovieDetails(int.parse(review.movieID));

                            ref
                                .watch(reviewViewModelProvider.notifier)
                                .getAllReviews(int.parse(review.movieID));
                          },
                          onLikeReview: (isLiked) {
                            if (isLiked) {
                              ref
                                  .watch(reviewViewModelProvider.notifier)
                                  .likeReview(
                                      int.parse(review.movieID), review.id);
                            } else {
                              ref
                                  .watch(reviewViewModelProvider.notifier)
                                  .dislikeReview(
                                      int.parse(review.movieID), review.id);
                            }

                            ref
                                .read(movieViewModelProvider.notifier)
                                .getMovieDetails(int.parse(review.movieID));

                            ref
                                .read(reviewViewModelProvider.notifier)
                                .getAllReviews(int.parse(review.movieID));
                          },
                        ),
                      );
                    } else {
                      return Container(
                        child: Text(
                          'No reviews for this movie yet.',
                          style: TextStyle(
                            fontSize: isTablet ? 22 : 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ); // Or show a placeholder for no reviews.
                    }
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
