import 'package:dio/dio.dart';

class Client {
  Client(this._dio);
  final Dio _dio;

  Future<Response<Map<String, dynamic>>> getTrending(String page) async {
    final path = 'trending/movie/week?page=$page&api_key=${_token()}';

    final Response<Map<String, dynamic>> response = await _dio.get(path);

    return response;
  }

  String _token() {
    return 'fb8a5d8320846ad46b648854e7e107b0';
  }
}
