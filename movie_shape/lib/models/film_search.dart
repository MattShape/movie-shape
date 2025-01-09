import 'package:movie_shape/models/film_summary.dart';

// Data representation of film by search request
class FilmsSearch {
  final List<FilmSummary> films;
  final String totalResults;
  final String response;

  FilmsSearch({
    required this.films,
    required this.totalResults,
    required this.response,
  });

  factory FilmsSearch.fromJson(Map<String, dynamic> json) {
    return FilmsSearch(
      // convert JSON list into FilmSummary class
      films: (json['Search'] as List<dynamic>?)
          ?.map((item) => FilmSummary.fromJson(item as Map<String, dynamic>))
          .toList() 
          ?? [],
      totalResults: json['totalResults'] ?? '0', 
      response: json['Response'] ?? 'False',     
    );
  }
}