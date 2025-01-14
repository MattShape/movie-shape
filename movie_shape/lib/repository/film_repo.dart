import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';

abstract class FilmRepo {
  Future<Film> getFilmById({required String id});
  Future<List<FilmSummary>> searchFilmsByTitle({required String searchQuery});
  Future<List<FilmSummary>?> getFavouritedFilms();
  Future<List<FilmSummary>?> getWatchlistFilms();
  Future<void> addFilmToWatchlist({required FilmSummary film});
  Future<void> removeFilmFromWatchlist({required FilmSummary film});
}
