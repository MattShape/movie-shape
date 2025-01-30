import 'package:movie_shape/models/film_summary.dart';

abstract class UserRepo {
  static const int userId = 1;
  // TODO: replace void with appropriate type
  Future<void> addFilmToWatchlist({required String movieId});
  Future<void> removeFilmFromWatchlist({required int movieId});
  Future<List<FilmSummary>> getWatchlistFilms();
  Future<void> addFilmToFavourites({required String movieId});
  Future<void> removeFilmFromFavourites({required String movieId});
  Future<List<FilmSummary>> getFavouritedFilms();
}
