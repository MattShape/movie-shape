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
  Future<void> getFilm({required filmId}) {
    // TODO: implement getFilm
    throw UnimplementedError();
  }

  @override
  Future<void> getFilms(
      {int? rowsPerPage, int? pageNumber, String? searchQuery}) {
    // TODO: implement getFilms
    throw UnimplementedError();
  }
}
