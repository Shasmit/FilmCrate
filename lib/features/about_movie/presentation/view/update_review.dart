import 'package:filmcrate/config/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_color_theme.dart';
import '../../../movies/presentation/viewmodel/movie_view_model.dart';
import '../viewmodel/all_review_view_model.dart';

class UpdateReview extends ConsumerStatefulWidget {
  const UpdateReview({Key? key}) : super(key: key);

  @override
  _UpdateReviewState createState() => _UpdateReviewState();
}

class _UpdateReviewState extends ConsumerState<UpdateReview> {
  int rating = 0;

  TextEditingController review = TextEditingController();

  String? reviewID;

  @override
  void didChangeDependencies() {
    reviewID = ModalRoute.of(context)!.settings.arguments as String?;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final movieState = ref.watch(movieViewModelProvider);

    if (movieState.isLoading) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Update your review',
          style: TextStyle(
            fontFamily: 'Dongle',
            fontSize: 40,
            fontWeight: FontWeight.normal,
            wordSpacing: 0,
            letterSpacing: 0.8,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Color(0xffDADADA),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Text(
                  movieState.allMovies[0].movie!.title!,
                  style: const TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 35,
                  ),
                ),
              ),
              const Divider(
                height: 2,
                color: Colors.grey,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      GestureDetector(
                        child: Icon(
                          Icons.star,
                          size: 55,
                          // size: isTablet ? 25 : 15,
                          color: (i < rating) ? Colors.green : Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            rating = i + 1;
                          });
                        },
                      ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Rating',
                  style: TextStyle(
                    fontFamily: 'Dongle',
                    fontSize: 30,
                  ),
                ),
              ),
              const Divider(
                height: 2,
                color: Colors.grey,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 30),
                child: TextFormField(
                  controller: review,
                  cursorColor: Colors.black,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove border lines
                    hintText: 'Update Review...',
                    hintStyle: TextStyle(
                      fontFamily: 'Dongle',
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final int movieId = movieState.allMovies[0].id!;
          final String reviews = review.text;
          final int ratings = rating;

          // Call the addReview method from the ReviewViewModel
          ref
              .watch(reviewViewModelProvider.notifier)
              .updateReview(movieId, reviews, ratings, reviewID!);

          Navigator.popAndPushNamed(context, AppRoute.allReviews);
          ref.read(reviewViewModelProvider.notifier).getAllReviews(movieId);
          ref.read(movieViewModelProvider.notifier).getMovieDetails(movieId);
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.check,
          size: 22,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
