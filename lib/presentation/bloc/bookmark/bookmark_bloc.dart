import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_bookmarked_movies.dart';
import '../../../domain/usecases/get_all_bookmarked_movie_ids.dart';
import '../../../domain/usecases/toggle_bookmark.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final GetBookmarkedMovies getBookmarkedMovies;
  final GetAllBookmarkedMovieIds getAllBookmarkedMovieIds;
  final ToggleBookmark toggleBookmark;

  BookmarkBloc({
    required this.getBookmarkedMovies,
    required this.getAllBookmarkedMovieIds,
    required this.toggleBookmark,
  }) : super(BookmarkInitial()) {
    on<LoadBookmarks>(_onLoadBookmarks);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
  }

  Future<void> _onLoadBookmarks(
    LoadBookmarks event,
    Emitter<BookmarkState> emit,
  ) async {
    emit(BookmarkLoading());

    final moviesResult = await getBookmarkedMovies(NoParams());
    final idsResult = await getAllBookmarkedMovieIds(NoParams());

    moviesResult.fold(
      (failure) => emit(BookmarkError(failure.message)),
      (movies) {
        idsResult.fold(
          (failure) => emit(BookmarkError(failure.message)),
          (ids) => emit(BookmarkLoaded(
            bookmarkedMovies: movies,
            bookmarkedIds: ids.toSet(),
          )),
        );
      },
    );
  }

  Future<void> _onToggleBookmark(
    ToggleBookmarkEvent event,
    Emitter<BookmarkState> emit,
  ) async {
    final currentState = state;

    // Toggle bookmark
    await toggleBookmark(BookmarkParams(movieId: event.movieId));

    // Reload bookmarks
    if (currentState is BookmarkLoaded) {
      final moviesResult = await getBookmarkedMovies(NoParams());
      final idsResult = await getAllBookmarkedMovieIds(NoParams());

      moviesResult.fold(
        (failure) => emit(BookmarkError(failure.message)),
        (movies) {
          idsResult.fold(
            (failure) => emit(BookmarkError(failure.message)),
            (ids) => emit(BookmarkLoaded(
              bookmarkedMovies: movies,
              bookmarkedIds: ids.toSet(),
            )),
          );
        },
      );
    }
  }
}
