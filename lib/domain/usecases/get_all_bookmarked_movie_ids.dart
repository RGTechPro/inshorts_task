import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/movie_repository.dart';

class GetAllBookmarkedMovieIds implements UseCase<List<int>, NoParams> {
  final MovieRepository repository;

  GetAllBookmarkedMovieIds(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async {
    return await repository.getAllBookmarkedMovieIds();
  }
}
