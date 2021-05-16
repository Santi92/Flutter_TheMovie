import 'package:get_it/get_it.dart';

abstract class BaseModule {
  BaseModule(this.sl);

  final GetIt sl;

  Future<void> init();
}
