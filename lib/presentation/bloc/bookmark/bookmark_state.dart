import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie_entity.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<MovieEntity> bookmarkedMovies;
  final Set<int> bookmarkedIds;

  const BookmarkLoaded({
    required this.bookmarkedMovies,
    required this.bookmarkedIds,
  });

  @override
  List<Object> get props => [bookmarkedMovies, bookmarkedIds];

  bool isBookmarked(int movieId) => bookmarkedIds.contains(movieId);
}

class BookmarkError extends BookmarkState {
  final String message;

  const BookmarkError(this.message);

  @override
  List<Object> get props => [message];
}
