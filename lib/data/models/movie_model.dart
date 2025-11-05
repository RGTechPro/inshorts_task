import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_entity.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends MovieEntity {
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

  @JsonKey(name: 'popularity')
  final double popularityField;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIdsField;

  @JsonKey(name: 'original_language')
  final String? originalLanguageField;

  @JsonKey(name: 'original_title')
  final String? originalTitleField;

  const MovieModel({
    required int id,
    required String title,
    required this.posterPathField,
    required this.backdropPathField,
    required String overview,
    required this.releaseDateField,
    required this.voteAverageField,
    required this.voteCountField,
    required this.popularityField,
    required this.genreIdsField,
    required this.originalLanguageField,
    required bool adult,
    required this.originalTitleField,
  }) : super(
          id: id,
          title: title,
          posterPath: posterPathField,
          backdropPath: backdropPathField,
          overview: overview,
          releaseDate: releaseDateField,
          voteAverage: voteAverageField,
          voteCount: voteCountField,
          popularity: popularityField,
          genreIds: genreIdsField,
          originalLanguage: originalLanguageField,
          adult: adult,
          originalTitle: originalTitleField,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  // For local database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'genre_ids': genreIds?.join(','),
      'original_language': originalLanguage,
      'adult': adult ? 1 : 0,
      'original_title': originalTitle,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int,
      title: map['title'] as String,
      posterPathField: map['poster_path'] as String?,
      backdropPathField: map['backdrop_path'] as String?,
      overview: map['overview'] as String,
      releaseDateField: map['release_date'] as String?,
      voteAverageField: (map['vote_average'] as num).toDouble(),
      voteCountField: map['vote_count'] as int,
      popularityField: (map['popularity'] as num).toDouble(),
      genreIdsField:
          map['genre_ids'] != null && (map['genre_ids'] as String).isNotEmpty
              ? (map['genre_ids'] as String)
                  .split(',')
                  .map((e) => int.parse(e))
                  .toList()
              : null,
      originalLanguageField: map['original_language'] as String?,
      adult: map['adult'] == 1,
      originalTitleField: map['original_title'] as String?,
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      posterPath: posterPath,
      backdropPath: backdropPath,
      overview: overview,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
      genreIds: genreIds,
      originalLanguage: originalLanguage,
      adult: adult,
      originalTitle: originalTitle,
    );
  }
}
