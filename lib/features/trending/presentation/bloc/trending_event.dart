import 'package:equatable/equatable.dart';

abstract class TrendingEvent extends Equatable {
  const TrendingEvent();
  @override
  List<Object> get props => [];
}

class LoadMovies extends TrendingEvent {}
