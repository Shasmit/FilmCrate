import 'package:filmcrate/features/movies/domain/entity/main_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_color_theme.dart';

class GenreDetails extends ConsumerWidget {
  final List<AllMovieEntity> allMovieList;
  const GenreDetails({Key? key, required this.allMovieList}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    List<String> genres = allMovieList.isNotEmpty
        ? allMovieList[0].movie!.genres!.map((genre) => genre.name).toList()
        : [];

    return SizedBox(
      height: isTablet ? 80 : 50,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 6 : 4,
          crossAxisSpacing: 6,
        ),
        itemCount: genres.length,
        itemBuilder: (BuildContext context, int index) {
          return Align(
            heightFactor: null,
            alignment: Alignment.topCenter,
            child: Container(
              height: isTablet ? 50 : 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColors.bodyColors,
              ),
              child: Center(
                child: Text(
                  genres[index],
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 20,
                    fontFamily: 'Dongle',
                    color: Colors.white,
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
