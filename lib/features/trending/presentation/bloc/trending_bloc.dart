import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_interactor.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_event.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc({required this.interactor}) : super(TrendingInitial());
  final TrendingInteractor interactor;
  @override
  Stream<TrendingState> mapEventToState(
    TrendingEvent event,
  ) async* {
    if (event is LoadMovies) {
      yield TrendingLoadingState();
      final _result = await interactor.getTrendingMovies();
      yield* _eitherLoadedOrErrorState(_result);
    }
  }

  Stream<TrendingState> _eitherLoadedOrErrorState(
    Either<Failure, List<Movie>> failureOrData,
  ) async* {
    yield failureOrData.fold(
      (failure) => _mapFailureToMessage(failure),
      (list) => TrendingLoadSuccess(movies: list),
    );
  }

  TrendingState _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ConnectNetworkFailure:
        return FailureConectionState();
      default:
        return ConenctionErrorState();
    }
  }
}
