import 'package:dartz/dartz.dart';
import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';

abstract class TrendingInteractor {
  Future<Either<Failure, List<Movie>>> getTrendingMovies(String numberPage);
}
