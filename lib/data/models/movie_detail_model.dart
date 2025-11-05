import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_detail_entity.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class GenreModel extends GenreEntity {
  const GenreModel({
    required super.id,
    required super.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}

@JsonSerializable()
class ProductionCompanyModel extends ProductionCompanyEntity {
  @JsonKey(name: 'logo_path')
  final String? logoPathField;
  @JsonKey(name: 'origin_country')
  final String originCountryField;

  const ProductionCompanyModel({
    required super.id,
    required super.name,
    required this.logoPathField,
    required this.originCountryField,
  }) : super(logoPath: logoPathField, originCountry: originCountryField);

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyModelToJson(this);
}

@JsonSerializable()
class MovieDetailModel extends MovieDetailEntity {
  @JsonKey(name: 'id')
  final int idField;
  @JsonKey(name: 'title')
  final String titleField;
  @JsonKey(name: 'overview')
  final String overviewField;
  @JsonKey(name: 'poster_path')
  final String? posterPathField;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPathField;
  @JsonKey(name: 'release_date')
  final String? releaseDateField;
  @JsonKey(name: 'vote_average')
  final double voteAverageField;
  @JsonKey(name: 'vote_count')
  final int voteCountField;
  @JsonKey(name: 'runtime')
  final int? runtimeField;
  @JsonKey(name: 'budget')
  final int budgetField;
  @JsonKey(name: 'revenue')
  final int revenueField;
  @JsonKey(name: 'genres')
  final List<GenreModel> genresField;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompanyModel> productionCompaniesField;
  @JsonKey(name: 'status')
  final String statusField;
  @JsonKey(name: 'tagline')
  final String? taglineField;
  @JsonKey(name: 'original_language')
  final String originalLanguageField;
  @JsonKey(name: 'popularity')
  final double popularityField;

  const MovieDetailModel({
    required this.idField,
    required this.titleField,
    required this.overviewField,
    required this.posterPathField,
    required this.backdropPathField,
    required this.releaseDateField,
    required this.voteAverageField,
    required this.voteCountField,
    required this.runtimeField,
    required this.budgetField,
    required this.revenueField,
    required this.genresField,
    required this.productionCompaniesField,
    required this.statusField,
    required this.taglineField,
    required this.originalLanguageField,
    required this.popularityField,
  }) : super(
          id: idField,
          title: titleField,
          overview: overviewField,
          posterPath: posterPathField,
          backdropPath: backdropPathField,
          releaseDate: releaseDateField,
          voteAverage: voteAverageField,
          voteCount: voteCountField,
          runtime: runtimeField ?? 0,
          budget: budgetField,
          revenue: revenueField,
          genres: genresField,
          productionCompanies: productionCompaniesField,
          status: statusField,
          tagline: taglineField,
          originalLanguage: originalLanguageField,
          popularity: popularityField,
        );

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailModelToJson(this);
}
