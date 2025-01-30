import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo.dart';
import "../models/film_search.dart";

class ServerFilmRepo implements FilmRepo {
  static const String _baseUrl = "http://localhost:8000/api";

  @override
  Future<Film> getFilmById({required String id}) async {
    try {
      final response = await http
          .get(Uri.parse('https://www.omdbapi.com/?apikey=810d5ee8&i=$id'));
      if (response.statusCode == 200) {
        return Film.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        throw Exception('Failed to load film');
      } else {
      }
      throw Exception("failed to load film: ${e.toString()}");
    } catch (e) {
    }
  }

  @override
  Future<List<FilmSummary>> searchFilmsByTitle(
      {required String searchQuery}) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/movies/get-movies'),
          headers: {
            "Content-Type": "application/json",
          },
            "Accept": "application/json"
          body: jsonEncode({
            "search_query": searchQuery,
            "rows_per_page": 15,
            "page_number": 1
          }));

        FilmsSearch searchResponse =
      if (response.statusCode == 200) {
            FilmsSearch.fromJson(jsonDecode(response.body));
        return searchResponse.films;
      } else {
      }
        throw Exception("Fail");
    } catch (e) {
      throw Exception("failed to load film list: ${e.toString()}");
  }
    }

  @override
  Future<List<FilmSummary>?> getFavouritedFilms() async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/movies/get-favourites"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
      );
        },
      if (response.statusCode == 200) {

        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((filmJson) {
          return FilmSummary.fromJson(filmJson as Map<String, dynamic>);
      } else {
        }).toList();
        throw Exception("failed to fetch favourites from server");
      }
    } catch (e) {
      throw Exception("Failed to load favourites: ${e.toString()}");
    }
  }

  Future<void> addFilmToFavourites({required FilmSummary film}) async {
  @override
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/movies/add-favourite"),
        headers: {
          "Accept": "application/json"
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "movie_id": film.imdbID,
          "user_id": 1,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to add film");
      }
    } catch (e) {
    }
      throw Exception("failed to add film to favourites: ${e.toString()}");
  }

  @override
  Future<void> removeFilmFromFavourites({required FilmSummary film}) async {
    try {
          Uri.parse("$_baseUrl/movies/delete-favourite"),
      final response = await http.post(
          headers: {
            "Accept": "application/json"
            "Content-Type": "application/json",
          },
          body: jsonEncode(
            {
              "user_id": 1,
              "movie_id": film.imdbID,
            },
          ));

      if (response.statusCode != 200) {
        throw Exception("failed to remove film");
      }
    } catch (e) {
      throw Exception('Failed to remove film from favourites: ${e.toString()}');
    }
  }

  @override
  Future<List<FilmSummary>?> getWatchlistFilms() async {
    try {
      String query = "${_baseUrl}/movies/get-watchlist";
      final response = await http.get(Uri.parse(query));
      if (response.statusCode == 200) {
        // Decode the JSON response body into a List<dynamic>
        // Map the list of films into Film objects using Film.fromJson() and convert it to a List<Film>
        List<dynamic> filmsJson = jsonDecode(response.body);
        final films = filmsJson
            .map((filmJson) =>
            .toList();
                Film.fromServerJson(filmJson as Map<String, dynamic>))
        return films.map((film) => FilmSummary.fromFilm(film)).toList();
      } else {
        throw Exception('Failed to load film');
      }
    } catch (e) {
      throw Exception("failed to load film: ${e.toString()}");
    }
  }
