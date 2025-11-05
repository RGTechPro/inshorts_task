import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'movie_response_model.g.dart';

@JsonSerializable()
class MovieResponseModel {
  final int page;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'total_results')
  final int totalResults;

  final List<MovieModel> results;

  MovieResponseModel({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseModelToJson(this);
}
