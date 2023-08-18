import 'package:dartz/dartz.dart';
import 'package:filmcrate/core/failure/failure.dart';
import 'package:filmcrate/features/search/domain/entity/search_movies_entity.dart';
import 'package:filmcrate/features/search/domain/repository/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dataSource/search_remote_data_source.dart';

final searchRemoteRepoProvider = Provider<ISearchRepository>(
  (ref) => SearchRemoteRepositoryImpl(
    searchRemoteDataSource: ref.read(searchRemoteDataSourceProvider),
  ),
);

class SearchRemoteRepositoryImpl implements ISearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;
  SearchRemoteRepositoryImpl({required this.searchRemoteDataSource});

  @override
  Future<Either<Failure, List<SearchEntity>>> getSearchedMovie(String name) {
    return searchRemoteDataSource.getSearchedMovies(name);
  }
}
