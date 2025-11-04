import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/movie_entity.dart';
import '../entities/movie_detail_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies();
  Future<Either<Failure, List<MovieEntity>>> getNowPlayingMovies();
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query);
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(int movieId);
  Future<Either<Failure, MovieEntity?>> getMovieById(int movieId);
  Future<Either<Failure, void>> addBookmark(int movieId);
  Future<Either<Failure, void>> removeBookmark(int movieId);
  Future<Either<Failure, bool>> isBookmarked(int movieId);
  Future<Either<Failure, List<MovieEntity>>> getBookmarkedMovies();
  Future<Either<Failure, List<int>>> getAllBookmarkedMovieIds();
}
