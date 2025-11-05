import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/movie_detail_entity.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetail implements UseCase<MovieDetailEntity, MovieDetailParams> {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  @override
  Future<Either<Failure, MovieDetailEntity>> call(
      MovieDetailParams params) async {
    return await repository.getMovieDetail(params.movieId);
  }
}

class MovieDetailParams extends Equatable {
  final int movieId;

  const MovieDetailParams({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
