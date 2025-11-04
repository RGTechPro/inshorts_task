import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String overview;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;
  final int runtime;
  final List<GenreEntity> genres;
  final List<ProductionCompanyEntity> productionCompanies;
  final String status;
  final String? tagline;
  final int budget;
  final int revenue;
  final String originalLanguage;
  final double popularity;

  const MovieDetailEntity({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    required this.overview,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.genres,
    required this.productionCompanies,
    required this.status,
    this.tagline,
    required this.budget,
    required this.revenue,
    required this.originalLanguage,
    required this.popularity,
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
        runtime,
        genres,
        productionCompanies,
        status,
        tagline,
        budget,
        revenue,
        originalLanguage,
        popularity,
      ];
}

class GenreEntity extends Equatable {
  final int id;
  final String name;

  const GenreEntity({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

class ProductionCompanyEntity extends Equatable {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  const ProductionCompanyEntity({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });

  @override
  List<Object?> get props => [id, name, logoPath, originCountry];
}
