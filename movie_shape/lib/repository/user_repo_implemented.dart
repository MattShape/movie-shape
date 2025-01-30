import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/models/film_list.dart';
import 'package:movie_shape/repository/user_repo.dart';

class UserRepoImplemented implements UserRepo {
  static const String _baseUrl = "http://localhost:8000/api";

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
  Future<List<Film>> getFavouritedFilms() {
    // TODO: implement getFavourites
    throw UnimplementedError();
  }

  @override
  Future<List<Film>> getWatchlistFilms() async {
    try {
      String query = "${_baseUrl}/movies/get-watchlist";
      final response = await http.get(Uri.parse(query));
      if (response.statusCode == 200) {
        final FilmList filmList = FilmList.fromJson(jsonDecode(response.body));
        return filmList.films;
      } else {
        throw Exception('Failed to load film');
      }
    } catch (e) {
      throw Exception("failed to load film: ${e.toString()}");
    }
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
