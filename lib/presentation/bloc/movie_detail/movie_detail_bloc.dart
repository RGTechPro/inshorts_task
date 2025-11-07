import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../core/constants/app_constants.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({required this.getMovieDetail})
      : super(MovieDetailInitial()) {
    on<LoadMovieDetail>(_onLoadMovieDetail);
    on<ShareMovie>(_onShareMovie);
  }

  Future<void> _onLoadMovieDetail(
    LoadMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());

    final result =
        await getMovieDetail(MovieDetailParams(movieId: event.movieId));

    result.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (movieDetail) => emit(MovieDetailLoaded(movieDetail)),
    );
  }

  Future<void> _onShareMovie(
    ShareMovie event,
    Emitter<MovieDetailState> emit,
  ) async {
    final deepLink =
        '${AppConstants.deepLinkScheme}://${AppConstants.deepLinkHost}/${event.movieId}';
    await Share.share(
      'Check out this movie: ${event.title}\n$deepLink',
      subject: 'Movie Recommendation',
    );
  }
}
