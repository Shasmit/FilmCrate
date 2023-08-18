import 'package:filmcrate/config/constants/app_color_theme.dart';
import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:filmcrate/features/movies/presentation/viewmodel/movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CastActors extends ConsumerWidget {
  final bool? isShowAll;
  final List<AllMovieEntity> allMovieList;
  const CastActors({super.key, this.isShowAll, required this.allMovieList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;
    final allMovieState = ref.watch(movieViewModelProvider);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 6 : 4,
          crossAxisSpacing: 6,
          childAspectRatio: isTablet ? 3 / 1 : 2 / 1,
        ),
        itemCount: isTablet
            ? isShowAll!
                ? allMovieState.allMovies[0].cast!.length
                : 6
            : isShowAll!
                ? allMovieState.allMovies[0].cast!.length
                : 4,
        itemBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: isTablet ? 40 : 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppColors.appbarColors,
                border: Border.all(
                  color: AppColors.bodyColors,
                  width: 1.0, // Set the border width
                ),
              ),
              child: Center(
                child: Text(
                  allMovieState.allMovies[0].cast![index].name,
                  // 'Colin Farrell',
                  style: TextStyle(
                    fontSize: isTablet ? 28 : 20,
                    fontFamily: 'Dongle',
                    color: AppColors.bodyColors,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
