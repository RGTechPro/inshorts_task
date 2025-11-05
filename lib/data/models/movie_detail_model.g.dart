// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreModel _$GenreModelFromJson(Map<String, dynamic> json) => GenreModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GenreModelToJson(GenreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProductionCompanyModel _$ProductionCompanyModelFromJson(
        Map<String, dynamic> json) =>
    ProductionCompanyModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      logoPathField: json['logo_path'] as String?,
      originCountryField: json['origin_country'] as String,
    );

Map<String, dynamic> _$ProductionCompanyModelToJson(
        ProductionCompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_path': instance.logoPathField,
      'origin_country': instance.originCountryField,
    };

MovieDetailModel _$MovieDetailModelFromJson(Map<String, dynamic> json) =>
    MovieDetailModel(
      idField: (json['id'] as num).toInt(),
      titleField: json['title'] as String,
      overviewField: json['overview'] as String,
      posterPathField: json['poster_path'] as String?,
      backdropPathField: json['backdrop_path'] as String?,
      releaseDateField: json['release_date'] as String?,
      voteAverageField: (json['vote_average'] as num).toDouble(),
      voteCountField: (json['vote_count'] as num).toInt(),
      runtimeField: (json['runtime'] as num?)?.toInt(),
      budgetField: (json['budget'] as num).toInt(),
      revenueField: (json['revenue'] as num).toInt(),
      genresField: (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCompaniesField: (json['production_companies'] as List<dynamic>)
          .map(
              (e) => ProductionCompanyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusField: json['status'] as String,
      taglineField: json['tagline'] as String?,
      originalLanguageField: json['original_language'] as String,
      popularityField: (json['popularity'] as num).toDouble(),
    );

Map<String, dynamic> _$MovieDetailModelToJson(MovieDetailModel instance) =>
    <String, dynamic>{
      'id': instance.idField,
      'title': instance.titleField,
      'overview': instance.overviewField,
      'poster_path': instance.posterPathField,
      'backdrop_path': instance.backdropPathField,
      'release_date': instance.releaseDateField,
      'vote_average': instance.voteAverageField,
      'vote_count': instance.voteCountField,
      'runtime': instance.runtimeField,
      'budget': instance.budgetField,
      'revenue': instance.revenueField,
      'genres': instance.genresField,
      'production_companies': instance.productionCompaniesField,
      'status': instance.statusField,
      'tagline': instance.taglineField,
      'original_language': instance.originalLanguageField,
      'popularity': instance.popularityField,
    };
