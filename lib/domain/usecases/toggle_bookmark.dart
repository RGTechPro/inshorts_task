import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/movie_repository.dart';

class ToggleBookmark implements UseCase<void, BookmarkParams> {
  final MovieRepository repository;

  ToggleBookmark(this.repository);

  @override
  Future<Either<Failure, void>> call(BookmarkParams params) async {
    final isBookmarkedResult = await repository.isBookmarked(params.movieId);

    return isBookmarkedResult.fold(
      (failure) => Left(failure),
      (isBookmarked) async {
        if (isBookmarked) {
          return await repository.removeBookmark(params.movieId);
        } else {
          return await repository.addBookmark(params.movieId);
        }
      },
    );
  }
}

class BookmarkParams extends Equatable {
  final int movieId;

  const BookmarkParams({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
