import 'package:dio/dio.dart';

class Client {
  Client(this._dio);
  final Dio _dio;

  Future<Response<Map<String, dynamic>>> getTrending(String page) async {
    final path = '/trending/movie/week';
    final queryParams = _buildParameters(page);

    final Response<Map<String, dynamic>> response =
        await _dio.get(path, queryParameters: queryParams);

    return response;
  }

  Map<String, dynamic> _buildParameters(String page) {
    return {'page': page, 'api_key': _token()};
  }

  String _token() {
    return 'fb8a5d8320846ad46b648854e7e107b0';
  }
}
