import 'package:dartz/dartz.dart';
import 'package:filmcrate/features/search/domain/repository/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/search_movies_entity.dart';

final searchUseCaseProvider = Provider<SearchUseCase>(
  (ref) => SearchUseCase(
    searchRepository: ref.watch(searchRepositoryProvider),
  ),
);

class SearchUseCase {
  final ISearchRepository searchRepository;

  SearchUseCase({
    required this.searchRepository,
  });

  Future<Either<Failure, List<SearchEntity>>> getSearchedMovie(
      String name) async {
    return await searchRepository.getSearchedMovie(name);
  }
}
