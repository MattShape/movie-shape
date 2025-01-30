import 'package:movie_shape/models/film.dart';

abstract class FilmRepo {
  // TODO: replace void with appropraite type
  Future<void> addFilm(
      {required String title,
      required String description,
      required int releaseDate,
      String? genre,
      double? rating});
  Future<void> removeFilm({required filmId});
  Future<Film> getFilmById({required filmId});
  Future<void> getFilms(
      {int? rowsPerPage, int? pageNumber, String? searchQuery});
}
