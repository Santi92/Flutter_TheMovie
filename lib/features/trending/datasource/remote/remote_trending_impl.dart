import 'package:dio/dio.dart';

import 'package:test_themoviedb/core/connection/client.dart';
import 'package:test_themoviedb/features/trending/datasource/object_dto/trending_response.dart';
import 'package:test_themoviedb/features/trending/datasource/remote/remote_trending.dart';

class RemoteTrendingImpl extends RemoteTrending {
  final Client client;

  RemoteTrendingImpl({required this.client});

  @override
  Future<TrendingResponse?> getTrendingMovies() async {
    final Response<Map<String, dynamic>> json = await client.getTrending('1');

    final TrendingResponse? responseObject =
        (json.data != null) ? TrendingResponse.fromJson(json.data!) : null;

    return responseObject;
  }
}
