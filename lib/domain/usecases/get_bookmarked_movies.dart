import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetBookmarkedMovies implements UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetBookmarkedMovies(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return await repository.getBookmarkedMovies();
  }
}
