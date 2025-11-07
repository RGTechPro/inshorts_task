import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../models/movie_model.dart';
import '../../models/movie_response_model.dart';
import '../../models/movie_detail_model.dart';

part 'movie_remote_data_source.g.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> searchMovies(String query);
  Future<MovieDetailModel> getMovieDetail(int movieId);
}

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class TmdbApiService {
  factory TmdbApiService(Dio dio, {String baseUrl}) = _TmdbApiService;

  @GET('/trending/movie/day')
  Future<MovieResponseModel> getTrendingMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );

  @GET('/movie/now_playing')
  Future<MovieResponseModel> getNowPlayingMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );

  @GET('/search/movie')
  Future<MovieResponseModel> searchMovies(
    @Query('api_key') String apiKey,
    @Query('query') String query,
    @Query('page') int page,
  );

  @GET('/movie/{movie_id}')
  Future<MovieDetailModel> getMovieDetail(
    @Path('movie_id') int movieId,
    @Query('api_key') String apiKey,
  );
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final TmdbApiService apiService;

  MovieRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    try {
      final response =
          await apiService.getTrendingMovies(ApiConstants.apiKey, 1);
      return response.results;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
            'Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
            'Connection error. Please check your internet connection.');
      } else if (e.response?.statusCode == 401) {
        throw ServerException('Invalid API key');
      } else if (e.response?.statusCode == 429) {
        throw ServerException('Too many requests. Please try again later.');
      } else {
        throw ServerException('Failed to fetch trending movies: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response =
          await apiService.getNowPlayingMovies(ApiConstants.apiKey, 1);
      return response.results;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
            'Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
            'Connection error. Please check your internet connection.');
      } else if (e.response?.statusCode == 401) {
        throw ServerException('Invalid API key');
      } else if (e.response?.statusCode == 429) {
        throw ServerException('Too many requests. Please try again later.');
      } else {
        throw ServerException(
            'Failed to fetch now playing movies: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response =
          await apiService.searchMovies(ApiConstants.apiKey, query, 1);
      return response.results;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
            'Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
            'Connection error. Please check your internet connection.');
      } else if (e.response?.statusCode == 401) {
        throw ServerException('Invalid API key');
      } else if (e.response?.statusCode == 429) {
        throw ServerException('Too many requests. Please try again later.');
      } else {
        throw ServerException('Failed to search movies: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    try {
      return await apiService.getMovieDetail(movieId, ApiConstants.apiKey);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException(
            'Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        throw NetworkException(
            'Connection error. Please check your internet connection and try again.');
      } else if (e.response?.statusCode == 401) {
        throw ServerException('Invalid API key');
      } else if (e.response?.statusCode == 404) {
        throw ServerException('Movie not found');
      } else if (e.response?.statusCode == 429) {
        throw ServerException('Too many requests. Please try again later.');
      } else {
        throw ServerException('Failed to fetch movie details: ${e.message}');
      }
    } catch (e) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}
