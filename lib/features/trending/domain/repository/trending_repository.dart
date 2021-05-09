import 'package:dartz/dartz.dart';
import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/datasource/object_dto/results.dart';

abstract class TrendingRepository {
  Future<Either<Failure, List<Result>>> getTradingMovies();
}
