abstract class UserRepo {
  static const int userId = 1;
  // TODO: replace void with appropraite type
  Future<void> addFilmToWatchlist({required String movieId});
  Future<void> removeFilmFromWatchlist({required String movieId});
  Future<void> getWatchlist();
  Future<void> addFilmToFavourites({required String movieId});
  Future<void> removeFilmFromFavourites({required String movieId});
  Future<void> getFavourites();
}
