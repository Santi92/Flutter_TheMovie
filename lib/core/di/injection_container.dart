import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_themoviedb/core/connection/client.dart';
import 'package:test_themoviedb/core/connection/networkInfo.dart';
import 'package:test_themoviedb/features/trending/di/trending_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());

  //Network
  final BaseOptions options = BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  final Dio dio = Dio(options);

  sl.registerLazySingleton(() => Client(dio));

  //! Features module
  TredingModule(sl).init();
}
