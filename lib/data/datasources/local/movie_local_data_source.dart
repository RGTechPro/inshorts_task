import '../../../core/error/exceptions.dart';
import '../../models/movie_model.dart';
import '../../../data/local/database_helper.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<void> cacheTrendingMovies(List<MovieModel> movies);
  Future<void> cacheNowPlayingMovies(List<MovieModel> movies);
  Future<MovieModel?> getMovieById(int movieId);
  Future<void> addBookmark(int movieId);
  Future<void> removeBookmark(int movieId);
  Future<bool> isBookmarked(int movieId);
  Future<List<MovieModel>> getBookmarkedMovies();
  Future<List<int>> getAllBookmarkedMovieIds();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    try {
      return await databaseHelper.getMoviesByCategory('trending');
    } catch (e) {
      throw CacheException('Failed to load trending movies from cache');
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      return await databaseHelper.getMoviesByCategory('now_playing');
    } catch (e) {
      throw CacheException('Failed to load now playing movies from cache');
    }
  }

  @override
  Future<void> cacheTrendingMovies(List<MovieModel> movies) async {
    try {
      await databaseHelper.deleteMoviesByCategory('trending');
      for (var movie in movies) {
        await databaseHelper.insertMovie(movie, 'trending');
      }
    } catch (e) {
      throw CacheException('Failed to cache trending movies');
    }
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieModel> movies) async {
    try {
      await databaseHelper.deleteMoviesByCategory('now_playing');
      for (var movie in movies) {
        await databaseHelper.insertMovie(movie, 'now_playing');
      }
    } catch (e) {
      throw CacheException('Failed to cache now playing movies');
    }
  }

  @override
  Future<MovieModel?> getMovieById(int movieId) async {
    try {
      return await databaseHelper.getMovieById(movieId);
    } catch (e) {
      throw CacheException('Failed to get movie by id');
    }
  }

  @override
  Future<void> addBookmark(int movieId) async {
    try {
      await databaseHelper.addBookmark(movieId);
    } catch (e) {
      throw CacheException('Failed to add bookmark');
    }
  }

  @override
  Future<void> removeBookmark(int movieId) async {
    try {
      await databaseHelper.removeBookmark(movieId);
    } catch (e) {
      throw CacheException('Failed to remove bookmark');
    }
  }

  @override
  Future<bool> isBookmarked(int movieId) async {
    try {
      return await databaseHelper.isBookmarked(movieId);
    } catch (e) {
      throw CacheException('Failed to check bookmark status');
    }
  }

  @override
  Future<List<MovieModel>> getBookmarkedMovies() async {
    try {
      return await databaseHelper.getBookmarkedMovies();
    } catch (e) {
      throw CacheException('Failed to get bookmarked movies');
    }
  }

  @override
  Future<List<int>> getAllBookmarkedMovieIds() async {
    try {
      return await databaseHelper.getAllBookmarkedMovieIds();
    } catch (e) {
      throw CacheException('Failed to get bookmarked movie ids');
    }
  }
}
