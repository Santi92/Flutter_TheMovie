import 'package:test_themoviedb/features/trending/datasource/object_dto/trending_response.dart';

abstract class RemoteTrending {
  Future<TrendingResponse> response();
}
