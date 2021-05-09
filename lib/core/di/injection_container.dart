import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_themoviedb/core/connection/networkInfo.dart';

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

  dio.interceptors.add(PrettyDioLogger());
  sl.registerLazySingleton(() => Client(dio));
  //sl.registerLazySingleton(
  //    () => RestClient(dio, baseUrl: 'https://system.boomerangbike.com'));

  //! Features module
  LoginModule(sl).init();
  HomeModule(sl).init();
  DeviceModule(sl).init();
  BikeDetailModule(sl).init();
  TripInfoModule(sl).init();
  SettingsModule(sl).init();
  TripsModule(sl).init();
  TripsDeditailModule(sl).init();
}
