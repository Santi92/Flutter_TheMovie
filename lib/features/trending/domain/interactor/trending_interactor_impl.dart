import 'package:dartz/dartz.dart';

import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_interactor.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_mapper.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';
import 'package:test_themoviedb/features/trending/domain/repository/trending_repository.dart';

class TrendingInteractorImpl extends TrendingInteractor {
  final TrendingRepository _respository;

  TrendingInteractorImpl(this._respository);

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies() async {
    final result = await _respository.getTradingMovies();

    return result.fold((l) {
      return Left(l);
    }, (results) async {
      final movies = TrendingMapper.mapperResultToMoviee(results);

      return Right(movies);
    });
  }
}
