import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<MovieEntity> movies;
  final String query;

  const SearchLoaded({required this.movies, required this.query});

  @override
  List<Object> get props => [movies, query];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchEmpty extends SearchState {}
