import 'package:dartz/dartz.dart';
import 'package:test_themoviedb/core/connection/networkInfo.dart';
import 'package:test_themoviedb/core/error/exceptions.dart';
import 'package:test_themoviedb/core/error/failure.dart';
import 'package:test_themoviedb/features/trending/datasource/object_dto/results.dart';
import 'package:test_themoviedb/features/trending/datasource/object_dto/trending_response.dart';
import 'package:test_themoviedb/features/trending/datasource/remote/remote_trending.dart';
import 'package:test_themoviedb/features/trending/domain/repository/trending_repository.dart';

class TrendingRepositoryImpl extends TrendingRepository {
  final NetworkInfo networkInfo;
  final RemoteTrending remoteTrending;

  TrendingRepositoryImpl(
      {required this.networkInfo, required this.remoteTrending});

  @override
  Future<Either<Failure, List<Result>>> getTradingMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final TrendingResponse? response =
            await remoteTrending.getTrendingMovies();

        if (response != null) {
          return Right(response.results);
        } else {
          return Right([]);
        }
      } on ServerException {
        return Left(ServerFailure());
      } on ServerNoFoundException {
        return Left(NotAuthorized());
      } on ServerUnauthorizedException {
        return Left(NotAuthorized());
      }
    }

    return Left(ConnectNetworkFailure());
  }
}
