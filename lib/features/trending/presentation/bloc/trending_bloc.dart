import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_interactor.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_event.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_state.dart';
import 'package:rxdart/rxdart.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  late int _numberPage = 1;
  TrendingBloc({required this.interactor}) : super(TrendingInitial());
  final TrendingInteractor interactor;
  @override
  Stream<TrendingState> mapEventToState(
    TrendingEvent event,
  ) async* {
    if (event is TrendingInitial) {
      this._numberPage = 1;
    }
    if (event is LoadMovies) {
      yield TrendingLoadingState();
      final _result = await interactor.getTrendingMovies('$_numberPage');
      yield* _eitherLoadedOrErrorState(_result);
    }

    if (event is PostFetched) {
      final _result = await interactor.getTrendingMovies('$_numberPage');
      yield* _eitherFechtLoadedOrErrorState(
          _result, state as TrendingLoadSuccess);
    }
  }

  Stream<TrendingState> _eitherLoadedOrErrorState(
    Either<Failure, List<Movie>> failureOrData,
  ) async* {
    yield failureOrData.fold(
      (failure) => _mapFailureToMessage(failure),
      (list) {
        _incrementPage();
        return TrendingLoadSuccess(movies: list, hasReachedMax: false);
      },
    );
  }

  Stream<TrendingState> _eitherFechtLoadedOrErrorState(
      Either<Failure, List<Movie>> failureOrData,
      TrendingLoadSuccess state) async* {
    yield failureOrData.fold(
      (failure) => _mapFailureToMessage(failure),
      (list) {
        _incrementPage();

        return list.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                movies: List.of(state.movies)..addAll(list),
                hasReachedMax: false,
              );
      },
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

  void _incrementPage() {
    this._numberPage++;
  }
}
