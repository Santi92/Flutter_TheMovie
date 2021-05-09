import 'package:test_themoviedb/features/trending/domain/models/movie.dart';

abstract class TrendingInteractor {
  List<Movie> getMovies();
}
