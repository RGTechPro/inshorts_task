import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/local/movie_local_data_source.dart';
import 'data/datasources/remote/movie_remote_data_source.dart';
import 'data/local/database_helper.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_all_bookmarked_movie_ids.dart';
import 'domain/usecases/get_bookmarked_movies.dart';
import 'domain/usecases/get_movie_detail.dart';
import 'domain/usecases/get_now_playing_movies.dart';
import 'domain/usecases/get_trending_movies.dart';
import 'domain/usecases/search_movies.dart';
import 'domain/usecases/toggle_bookmark.dart';
import 'presentation/bloc/bookmark/bookmark_bloc.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'presentation/bloc/navigation/navigation_bloc.dart';
import 'presentation/bloc/search/search_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs
  sl.registerFactory(
    () => HomeBloc(
      getTrendingMovies: sl(),
      getNowPlayingMovies: sl(),
    ),
  );

  sl.registerFactory(
    () => SearchBloc(searchMovies: sl()),
  );

  sl.registerFactory(
    () => BookmarkBloc(
      getBookmarkedMovies: sl(),
      getAllBookmarkedMovieIds: sl(),
      toggleBookmark: sl(),
    ),
  );

  sl.registerFactory(
    () => MovieDetailBloc(getMovieDetail: sl()),
  );

  sl.registerFactory(
    () => NavigationBloc(),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTrendingMovies(sl()));
  sl.registerLazySingleton(() => GetNowPlayingMovies(sl()));
  sl.registerLazySingleton(() => SearchMovies(sl()));
  sl.registerLazySingleton(() => GetMovieDetail(sl()));
  sl.registerLazySingleton(() => GetBookmarkedMovies(sl()));
  sl.registerLazySingleton(() => GetAllBookmarkedMovieIds(sl()));
  sl.registerLazySingleton(() => ToggleBookmark(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(sl()),
  );

  // External
  sl.registerLazySingleton(() {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ));

    // Add interceptor for logging (optional, can help with debugging)
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (obj) => print('[DIO] $obj'),
    ));

    return dio;
  });

  sl.registerLazySingleton(() => TmdbApiService(sl()));
  sl.registerLazySingleton(() => DatabaseHelper.instance);
}
