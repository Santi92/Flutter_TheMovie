import 'package:test_themoviedb/features/trending/datasource/object_dto/results.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';

class TrendingMapper {
  static List<Movie> mapperResultToMoviee(List<Result> response) {
    List<Movie> movies = [];

    movies = response
        .map((e) => Movie(
            posterPath: e.posterPath,
            title: e.title,
            voteAverage: e.voteAverage,
            releaseDate: e.releaseDate))
        .toList();

    return movies;
  }
}
