import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/user_repo.dart';

class UserRepoImplemented implements UserRepo {
  @override
  Future<void> addFilmToFavourites({required String movieId}) {
    // TODO: implement addFilmToFavourites
    throw UnimplementedError();
  }

  @override
  Future<void> addFilmToWatchlist({required String movieId}) {
    // TODO: implement addFilmToWatchlist
    throw UnimplementedError();
  }

  @override
  Future<List<FilmSummary>> getFavouritedFilms() {
    // TODO: implement getFavourites
    throw UnimplementedError();
  }

  @override
  Future<List<FilmSummary>> getWatchlistFilms() {
    // TODO: implement getWatchlist
    throw UnimplementedError();
  }

  @override
  Future<void> removeFilmFromFavourites({required String movieId}) {
    // TODO: implement removeFilmFromFavourites
    throw UnimplementedError();
  }

  @override
  Future<void> removeFilmFromWatchlist({required int movieId}) {
    // TODO: implement removeFilmFromWatchlist
    throw UnimplementedError();
  }
}
