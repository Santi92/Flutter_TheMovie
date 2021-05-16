import 'package:equatable/equatable.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';

abstract class TrendingState extends Equatable {
  const TrendingState();
  @override
  List<Object> get props => [];
}

class TrendingInitial extends TrendingState {}

class TrendingLoadingState extends TrendingState {}

class FailureConectionState extends TrendingState {}

class ConenctionErrorState extends TrendingState {}

class TrendingLoadSuccess extends TrendingState {
  const TrendingLoadSuccess({
    required this.hasReachedMax,
    required this.movies,
  });

  final List<Movie> movies;
  final bool hasReachedMax;

  TrendingLoadSuccess copyWith({
    List<Movie>? movies,
    bool? hasReachedMax,
  }) {
    return TrendingLoadSuccess(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [movies.toString()];

  @override
  String toString() {
    return movies.toString();
  }
}
