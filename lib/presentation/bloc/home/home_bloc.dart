import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_trending_movies.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTrendingMovies getTrendingMovies;
  final GetNowPlayingMovies getNowPlayingMovies;

  HomeBloc({
    required this.getTrendingMovies,
    required this.getNowPlayingMovies,
  }) : super(HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<RefreshMovies>(_onRefreshMovies);
  }

  Future<void> _onLoadMovies(
    LoadMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    await _fetchMovies(emit);
  }

  Future<void> _onRefreshMovies(
    RefreshMovies event,
    Emitter<HomeState> emit,
  ) async {
    await _fetchMovies(emit);
  }

  Future<void> _fetchMovies(Emitter<HomeState> emit) async {
    final trendingResult = await getTrendingMovies(NoParams());
    final nowPlayingResult = await getNowPlayingMovies(NoParams());

    trendingResult.fold(
      (failure) => emit(HomeError(failure.message)),
      (trending) {
        nowPlayingResult.fold(
          (failure) => emit(HomeError(failure.message)),
          (nowPlaying) => emit(HomeLoaded(
            trendingMovies: trending,
            nowPlayingMovies: nowPlaying,
          )),
        );
      },
    );
  }
}
