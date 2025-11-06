import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class LoadBookmarks extends BookmarkEvent {}

class ToggleBookmarkEvent extends BookmarkEvent {
  final int movieId;

  const ToggleBookmarkEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
