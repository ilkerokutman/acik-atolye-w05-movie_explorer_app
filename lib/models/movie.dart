import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final int id;
  final String title;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  String get fullPosterPath => 
      posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : '';
  
  String get fullBackdropPath => 
      backdropPath != null ? 'https://image.tmdb.org/t/p/w1280$backdropPath' : '';

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
