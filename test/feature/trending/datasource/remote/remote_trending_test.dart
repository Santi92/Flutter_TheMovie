import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:test_themoviedb/core/connection/client.dart';
import 'package:test_themoviedb/features/trending/datasource/object_dto/trending_response.dart';
import 'package:test_themoviedb/features/trending/datasource/remote/remote_trending_impl.dart';

import '../../../../tools/data_trending_mock.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late RemoteTrendingImpl remoteData;
  late Client mockHttpClient;

  late Dio tdio;
  final dioAdapterMock = DioAdapter();

  setUp(() async {
    //Network
    tdio = new Dio()..httpClientAdapter = dioAdapterMock;

    mockHttpClient = Client(tdio);
    remoteData = RemoteTrendingImpl(client: mockHttpClient);
  });

  test(
    'should get successful movie trending from the client',
    () async {
      //arrange
      final TrendingResponse expectTreding =
          trendingResponseFromJson(trendingJson());

      dioAdapterMock.onGet(
          'trending/movie/week?page=1&api_key=fb8a5d8320846ad46b648854e7e107b0',
          (request) => request.reply(200, expectTreding.toJson()));

      //act
      final result = await remoteData.getTrendingMovies();
      //assert
      expect(result.toString(), expectTreding.toString());
    },
  );

  test(
    'should get No Unauthorized user from the api',
    () async {
      //arrange
      dioAdapterMock.onGet(
        'trending/movie/week?page=1&api_key=fb8a5d8320846ad46b648854e7e107b0',
        (request) => request.reply(400, {
          "status_code": 7,
          "status_message": "Invalid API key: You must be granted a valid key.",
          "success": false
        }),
      );
      try {
        //act
        await remoteData.getTrendingMovies();
      } catch (e) {
        expect(e, isInstanceOf<DioError>());
      }
    },
  );
}
