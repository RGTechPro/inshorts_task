import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/usecases/search_movies.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  SearchBloc({required this.searchMovies}) : super(SearchInitial()) {
    // Apply debounce to SearchQueryChanged events
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: (events, mapper) => events
          .debounceTime(
             const Duration(milliseconds: AppConstants.searchDebounceMilliseconds))
          .switchMap(mapper),
    );
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchEmpty());
      return;
    }

    emit(SearchLoading());

    final result = await searchMovies(SearchParams(query: query));

    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (movies) => emit(SearchLoaded(movies: movies, query: query)),
    );
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }
}
