import 'package:test_themoviedb/features/trending/datasource/object_dto/results.dart';

abstract class TrendingRepository {
  Future<List<Result>> getTradingMovies();
}
