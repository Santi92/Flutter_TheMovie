import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_themoviedb/core/connection/networkInfo.dart';
import 'package:test_themoviedb/core/error/exceptions.dart';

import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/datasource/object_dto/results.dart';
import 'package:test_themoviedb/features/trending/datasource/object_dto/trending_response.dart';
import 'package:test_themoviedb/features/trending/datasource/remote/remote_trending.dart';
import 'package:test_themoviedb/features/trending/domain/repository/trending_repository.dart';
import 'package:test_themoviedb/features/trending/domain/repository/trending_repository_impl.dart';

import '../../../../tools/data_trending_mock.dart';

class MockRemoteTrendingy extends Mock implements RemoteTrending {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late RemoteTrending remoteDate;
  late NetworkInfo networkInfo;
  late TrendingRepository repository;

  setUp(() {
    remoteDate = MockRemoteTrendingy();
    networkInfo = MockNetworkInfo();

    repository = TrendingRepositoryImpl(
        networkInfo: networkInfo, remoteTrending: remoteDate);
  });

  test(
    'should check if the device is ofline',
    () async {
      // arrange
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remoteDate.getTrendingMovies("1"))
          .thenAnswer((_) async => Future.value(null));
      // act
      await repository.getTradingMovies("1");
      // assert
      verify(() => networkInfo.isConnected);
    },
  );

  test(
    'should get a list of trending movies when the call data from is successful',
    () async {
      final response = trendingResponseFromJson(trendingJson());
      // arrange
      when(() => remoteDate.getTrendingMovies("1"))
          .thenAnswer((_) async => Future.value(response));
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);

      // act
      final result = await repository.getTradingMovies("1");
      // assert
      verify(() => remoteDate.getTrendingMovies("1"));
      verify(() => networkInfo.isConnected);
      expect(result.getOrElse(() => []), response.results);
    },
  );

  test(
    'should get a connection error when the device is without internet',
    () async {
      // arrange
      when(() => networkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.getTradingMovies("1");
      // assert
      verifyNever(() => remoteDate.getTrendingMovies("1"));
      verify(() => networkInfo.isConnected);
      expect(
        result,
        Left<Failure, List<Result>>(ConnectNetworkFailure()),
      );
    },
  );

  test(
    'should receive an authorization when the app does not have a valid token',
    () async {
      // arrange
      when(() => remoteDate.getTrendingMovies("1"))
          .thenThrow(ServerUnauthorizedException());
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);

      // act
      final result = await repository.getTradingMovies("1");
      // assert
      verify(() => remoteDate.getTrendingMovies("1"));
      verify(() => networkInfo.isConnected);
      expect(result, Left<Failure, List<Result>>(NotAuthorized()));
    },
  );

  test(
    'should receive a from server when the server fails like for example a 500',
    () async {
      // arrange
      when(() => remoteDate.getTrendingMovies("1"))
          .thenThrow(ServerException());
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);

      // act
      final result = await repository.getTradingMovies("1");
      // assert
      verify(() => remoteDate.getTrendingMovies("1"));
      verify(() => networkInfo.isConnected);
      expect(result, Left<Failure, List<Result>>(ServerFailure()));
    },
  );

  test(
    'should receive a from server when the resource is not found',
    () async {
      // arrange
      when(() => remoteDate.getTrendingMovies("1"))
          .thenThrow(ServerUnauthorizedException());
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);

      // act
      final result = await repository.getTradingMovies("1");
      // assert
      verify(() => remoteDate.getTrendingMovies("1"));
      verify(() => networkInfo.isConnected);
      expect(result, Left<Failure, List<Result>>(NotAuthorized()));
    },
  );
}
