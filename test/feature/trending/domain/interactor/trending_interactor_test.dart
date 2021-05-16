import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/datasource/object_dto/results.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_interactor.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_interactor_impl.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';
import 'package:test_themoviedb/features/trending/domain/repository/trending_repository.dart';

class MockTrendingRepository extends Mock implements TrendingRepository {}

void main() {
  late TrendingInteractor interactor;
  late TrendingRepository repository;

  setUp(() {
    repository = MockTrendingRepository();
    interactor = TrendingInteractorImpl(repository);
  });

  test(
    'should get successfully have the trending movies associated to week',
    () async {
      //arrange
      when(() => repository.getTradingMovies("1"))
          .thenAnswer((_) => Future.value(
                Right<Failure, List<Result>>([]),
              ));

      //act
      final result = await interactor.getTrendingMovies("1");

      //assert
      expect(result.isRight(), true);
      expect(result.getOrElse(() => [Movie(title: "test"), Movie()]), []);
      verify(() => repository.getTradingMovies("1"));
    },
  );

  test(
    'should get error Not Authorized have the trending movies associated to week',
    () async {
      //arrange
      when(() => repository.getTradingMovies("1"))
          .thenAnswer((_) => Future.value(
                Left<Failure, List<Result>>(NotAuthorized()),
              ));

      //act
      final result = await interactor.getTrendingMovies("1");

      //assert
      expect(
        result,
        Left<Failure, List<Movie>>(NotAuthorized()),
      );
      verify(() => repository.getTradingMovies("1"));
    },
  );
}
