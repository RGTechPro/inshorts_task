// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      posterPathField: json['poster_path'] as String?,
      backdropPathField: json['backdrop_path'] as String?,
      overview: json['overview'] as String,
      releaseDateField: json['release_date'] as String?,
      voteAverageField: (json['vote_average'] as num).toDouble(),
      voteCountField: (json['vote_count'] as num).toInt(),
      popularityField: (json['popularity'] as num).toDouble(),
      genreIdsField: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      originalLanguageField: json['original_language'] as String?,
      adult: json['adult'] as bool,
      originalTitleField: json['original_title'] as String?,
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'adult': instance.adult,
      'poster_path': instance.posterPathField,
      'backdrop_path': instance.backdropPathField,
      'release_date': instance.releaseDateField,
      'vote_average': instance.voteAverageField,
      'vote_count': instance.voteCountField,
      'popularity': instance.popularityField,
      'genre_ids': instance.genreIdsField,
      'original_language': instance.originalLanguageField,
      'original_title': instance.originalTitleField,
    };
