import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo.dart';

// Repository for handling API requests with OMDb API
class FilmRepoImplemented implements FilmRepo {
  static const String _baseUrl = "http://localhost:8000/api";

  @override
  Future<void> addFilm(
      {required String title,
      required String description,
      required int releaseDate,
      String? genre,
      double? rating}) {
    // TODO: implement addFilm
    throw UnimplementedError();
  }

  @override
  Future<void> removeFilm({required filmId}) {
    // TODO: implement removeFilm
    throw UnimplementedError();
  }

  @override
  Future<Film> getFilmById({required filmId}) async {
    try {
      String query = "${_baseUrl}/movies/${filmId}";
      final response = await http.get(Uri.parse(query));
      if (response.statusCode == 200) {
        return Film.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load film');
      }
    } catch (e) {
      throw Exception("failed to load film: ${e.toString()}");
    }
  }

  @override
  Future<List<FilmSummary>> getFilms(
      {int? rowsPerPage, int? pageNumber, String? searchQuery}) async {
    // TODO: implement getFilms
    throw UnimplementedError();
  }
}
