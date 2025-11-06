import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieEntity> trendingMovies;
  final List<MovieEntity> nowPlayingMovies;

  const HomeLoaded({
    required this.trendingMovies,
    required this.nowPlayingMovies,
  });

  @override
  List<Object> get props => [trendingMovies, nowPlayingMovies];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
