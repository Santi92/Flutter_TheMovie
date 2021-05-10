import 'package:get_it/get_it.dart';
import 'package:test_themoviedb/core/di/base_module.dart';
import 'package:test_themoviedb/features/trending/datasource/remote/remote_trending.dart';
import 'package:test_themoviedb/features/trending/datasource/remote/remote_trending_impl.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_interactor.dart';
import 'package:test_themoviedb/features/trending/domain/interactor/trending_interactor_impl.dart';
import 'package:test_themoviedb/features/trending/domain/repository/trending_repository.dart';
import 'package:test_themoviedb/features/trending/domain/repository/trending_repository_impl.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_bloc.dart';

class TredingModule extends BaseModule {
  TredingModule(GetIt sl) : super(sl);

  @override
  Future<void> init() async {
    // Data sources
    sl.registerLazySingleton<RemoteTrending>(
      () => RemoteTrendingImpl(client: sl()),
    );

    // Repository
    sl.registerLazySingleton<TrendingRepository>(
      () => TrendingRepositoryImpl(
        networkInfo: sl(),
        remoteTrending: sl(),
      ),
    );

    // Use case (Interactor)

    sl.registerLazySingleton<TrendingInteractor>(
      () => TrendingInteractorImpl(sl()),
    );

    // Bloc
    sl.registerFactory(
      () => TrendingBloc(
        interactor: sl(),
      ),
    );
  }
}
