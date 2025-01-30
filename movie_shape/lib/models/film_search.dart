import 'package:movie_shape/models/film_summary.dart';

// Data representation of film by search request
class FilmsSearch {
  final List<FilmSummary> currentPage;
  final int totalResults;
  final int rowsPerPage;
  final int totalPages;

  FilmsSearch({
    required this.currentPage,
    required this.totalResults,
    required this.rowsPerPage,
    required this.totalPages,
  });

  factory FilmsSearch.fromJson(Map<String, dynamic> json) {
    return FilmsSearch(
      currentPage: (json['current_page'] as List)
          .map((item) => FilmSummary.fromJson(item))
          .toList(),
      totalResults: json['total_results'],
      rowsPerPage: json['rows_per_page'],
      totalPages: json['total_pages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage.map((movie) => movie.toJson()).toList(),
      'total_results': totalResults,
      'rows_per_page': rowsPerPage,
      'total_pages': totalPages,
    };
  }
}
