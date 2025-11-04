import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<int>? genreIds;
  final String? originalLanguage;
  final bool adult;
  final String? originalTitle;

  const MovieEntity({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    required this.overview,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.genreIds,
    this.originalLanguage,
    required this.adult,
    this.originalTitle,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        backdropPath,
        overview,
        releaseDate,
        voteAverage,
        voteCount,
        popularity,
        genreIds,
        originalLanguage,
        adult,
        originalTitle,
      ];
}
