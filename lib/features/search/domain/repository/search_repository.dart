import 'package:dartz/dartz.dart';
import 'package:filmcrate/features/search/data/repository/search_remote_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/search_movies_entity.dart';

final searchRepositoryProvider = Provider<ISearchRepository>(
  (ref) => ref.watch(searchRemoteRepoProvider),
);

abstract class ISearchRepository {
  Future<Either<Failure, List<SearchEntity>>> getSearchedMovie(String name);
}
