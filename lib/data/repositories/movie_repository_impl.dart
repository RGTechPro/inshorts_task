import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/local/movie_local_data_source.dart';
import '../datasources/remote/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies() async {
    try {
      // Try remote first
      final remoteMovies = await remoteDataSource.getTrendingMovies();
      // Cache the results
      await localDataSource.cacheTrendingMovies(remoteMovies);
      return Right(remoteMovies);
    } on ServerException catch (e) {
      // If remote fails, try cache
      try {
        final cachedMovies = await localDataSource.getTrendingMovies();
        return Right(cachedMovies);
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    } on NetworkException catch (e) {
      // If network fails, try cache
      try {
        final cachedMovies = await localDataSource.getTrendingMovies();
        return Right(cachedMovies);
      } on CacheException {
        return Left(NetworkFailure(e.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getNowPlayingMovies() async {
    try {
      // Try remote first
      final remoteMovies = await remoteDataSource.getNowPlayingMovies();
      // Cache the results
      await localDataSource.cacheNowPlayingMovies(remoteMovies);
      return Right(remoteMovies);
    } on ServerException catch (e) {
      // If remote fails, try cache
      try {
        final cachedMovies = await localDataSource.getNowPlayingMovies();
        return Right(cachedMovies);
      } on CacheException {
        return Left(ServerFailure(e.message));
      }
    } on NetworkException catch (e) {
      // If network fails, try cache
      try {
        final cachedMovies = await localDataSource.getNowPlayingMovies();
        return Right(cachedMovies);
      } on CacheException {
        return Left(NetworkFailure(e.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query) async {
    try {
      final movies = await remoteDataSource.searchMovies(query);
      return Right(movies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(int movieId) async {
    try {
      final movieDetail = await remoteDataSource.getMovieDetail(movieId);
      return Right(movieDetail);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieEntity?>> getMovieById(int movieId) async {
    try {
      final movie = await localDataSource.getMovieById(movieId);
      return Right(movie);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addBookmark(int movieId) async {
    try {
      await localDataSource.addBookmark(movieId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeBookmark(int movieId) async {
    try {
      await localDataSource.removeBookmark(movieId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isBookmarked(int movieId) async {
    try {
      final isBookmarked = await localDataSource.isBookmarked(movieId);
      return Right(isBookmarked);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getBookmarkedMovies() async {
    try {
      final movies = await localDataSource.getBookmarkedMovies();
      return Right(movies);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getAllBookmarkedMovieIds() async {
    try {
      final ids = await localDataSource.getAllBookmarkedMovieIds();
      return Right(ids);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
