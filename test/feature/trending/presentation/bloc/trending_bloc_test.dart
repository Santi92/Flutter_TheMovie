import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:test/test.dart';
import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_interactor.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';

import 'package:test_themoviedb/features/trending/presentation/bloc/trending_bloc.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_event.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_state.dart';

class MocktTrendingInteractor extends Mock implements TrendingInteractor {}

void main() {
  late TrendingInteractor interactor;
  late TrendingBloc bloc;

  setUp(() {
    interactor = MocktTrendingInteractor();
    bloc = TrendingBloc(interactor: interactor);
  });

  group('Trending Bloc', () {
    test('initial state is device bloc', () {
      expect(bloc.state, TrendingInitial());
    });

    blocTest<TrendingBloc, TrendingState>(
      'should emit Success load moovied in to an LoadMovies event',
      build: () {
        when(() => interactor.getTrendingMovies())
            .thenAnswer((_) => Future.value(
                  Right<Failure, List<Movie>>([]),
                ));
        return bloc;
      },
      act: (bloc) async => bloc.add(LoadMovies()),
      expect: () => <TrendingState>[
        TrendingLoadingState(),
        const TrendingLoadSuccess(movies: [])
      ],
    );

    blocTest<TrendingBloc, TrendingState>(
      'should emit FailedConnection in to an LoadMovies is event',
      build: () {
        when(() => interactor.getTrendingMovies())
            .thenAnswer((_) async => Left(ConnectNetworkFailure()));
        return bloc;
      },
      act: (bloc) async => bloc.add(LoadMovies()),
      expect: () => <TrendingState>[
        TrendingLoadingState(),
        FailureConectionState(),
      ],
    );

    blocTest<TrendingBloc, TrendingState>(
      'should emit ServerFailure load devices in to an LoadDevices event',
      build: () {
        when(() => interactor.getTrendingMovies())
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) async => bloc.add(LoadMovies()),
      expect: () => <TrendingState>[
        TrendingLoadingState(),
        ConenctionErrorState(),
      ],
    );
  });
}
