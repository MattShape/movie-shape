import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/models/rating.dart';
import 'package:movie_shape/repository/film_repo.dart';
import "../models/film_search.dart";

Film fromServerJson(Map<String, dynamic> json) {
  const String defaultPosterUrl =
      'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';

  var film = Film(
    title: json['title'] as String? ?? 'N/A',
    year: (json['release_date'] as int?).toString() ?? 'N/A',
    rated: json['certificate'] as String? ?? 'N/A',
    released: json['released'] as String? ?? 'N/A',
    runtime: json['runtime'] as String? ?? 'N/A',
    genre: json['genre'] as String? ?? 'N/A',
    director: json['director'] as String? ?? 'N/A',
    // TODO: NO WRITER FROM SERVER RESPONSE
    writer: (json['writer'] as String?)
            ?.split(',')
            .map((writer) => writer.trim())
            .toList() ??
        ['N/A'],
    actors: [
      json['star1'] as String? ?? 'N/A',
      json['star2'] as String? ?? 'N/A',
      json['star3'] as String? ?? 'N/A',
      json['star4'] as String? ?? 'N/A',
    ],
    plot: json['description'] as String? ?? 'N/A',
    // TODO: NO LANGUAGE FROM SERVER RESPONSE
    language: (json['language'] as String?)
            ?.split(',')
            .map((actor) => actor.trim())
            .toList() ??
        ['N/A'],
    // TODO: NO COUNTRY FROM SERVER RESPONSE
    country: json['country'] as String? ?? 'N/A',
    // TODO: NO AWARDS FROM SERVER RESPONSE
    awards: (json['awards'] as String?)
            ?.split(RegExp(r'[.&]')) // Split by "." and "&"
            .map((part) => part.trim()) // Trim whitespace
            .toList() ??
        [],
    poster: Uri.tryParse(json['poster_link'] ?? '')?.hasAbsolutePath == true
        ? json['poster_link']
        : defaultPosterUrl,
    ratings: [
      Rating(
          source: 'IMDb',
          value: (json['rating'] as double?).toString() ?? 'N/A'),
      Rating(
          source: 'Metascore',
          value: (json['meta_score'] as int?).toString() ??
              'N/A'), // SQL Column: meta_score
    ],
    metascore: (json['meta_score'] as int?).toString() ?? 'N/A',
    imdbRating: (json['rating'] as double?).toString() ?? 'N/A',
    imdbVotes: (json['no_of_votes'] as int?).toString() ??
        'N/A', // SQL Column: no_of_votes
    imdbId: (json['id'] as int?).toString() ?? 'N/A',
    type: 'Film',
    dvd: 'N/A',
    boxOffice: json['gross'] as String? ?? 'N/A',
    // TODO: no production from SERVER RESPONSE
    production: json['production'] as String? ?? 'N/A',
    response: 'True',
  );

  return film;
}

class ServerFilmRepo implements FilmRepo {
  static const String _baseUrl = "http://localhost:8000/api";

  @override
  Future<Film> getFilmById({required String id}) async {
    try {
      String query = "${_baseUrl}/movies/${id}";
      final response = await http.get(Uri.parse(query));
      if (response.statusCode == 200) {
        return fromServerJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load film');
      }
    } catch (e) {
      throw Exception("failed to load film: ${e.toString()}");
    }
  }

  @override
  Future<List<FilmSummary>> searchFilmsByTitle(
      {required String searchQuery}) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/movies/get-movies'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode({
            "search_query": searchQuery,
            "rows_per_page": 15,
            "page_number": 1
          }));

      if (response.statusCode == 200) {
        FilmsSearch searchResponse =
            FilmsSearch.fromJson(jsonDecode(response.body));
        return searchResponse.films;
      } else {
        throw Exception("Fail");
      }
    } catch (e) {
      throw Exception("failed to load film list: ${e.toString()}");
    }
  }

  @override
  Future<void> addFilmToWatchlist({required FilmSummary film}) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/movies/add-movie-to-watchlist"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
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
      throw Exception("failed to add film to favourites: ${e.toString()}");
    }
  }

  @override
  Future<void> removeFilmFromWatchlist({required FilmSummary film}) async {
    try {
      final response = await http.post(
          Uri.parse("$_baseUrl/movies/remove-movie-from-watchlist"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(
            {
              "movie_id": film.imdbID,
              "user_id": 1,
            },
          ));

      if (response.statusCode != 200) {
        throw Exception('Failed to remove film from watchlist');
      }
    } catch (e) {
      throw Exception("failed to remove film watchlist: ${e.toString()}");
    }
  }

  @override
  Future<List<FilmSummary>?> getWatchlistFilms() async {
    try {
      await Future.delayed(Duration(milliseconds: 750));
      String query = "${_baseUrl}/movies/get-watchlist";
      final response = await http.get(Uri.parse(query));
      if (response.statusCode == 200) {
        // Decode the JSON response body into a List<dynamic>
        List<dynamic> filmsJson = jsonDecode(response.body);
        // Map the list of films into Film objects using Film.fromJson() and convert it to a List<Film>
        final films = filmsJson
            .map((filmJson) => fromServerJson(filmJson as Map<String, dynamic>))
            .toList();
        return films.map((film) => FilmSummary.fromFilm(film)).toList();
      } else {
        throw Exception('Failed to load watchlist');
      }
    } catch (e) {
      throw Exception("failed to load watchlist: ${e.toString()}");
    }
  }

  @override
  Future<void> addFilmToFavourites({required FilmSummary film}) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/movies/add-favourite"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
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
      throw Exception("failed to add film to favourites: ${e.toString()}");
    }
  }

  @override
  Future<void> removeFilmFromFavourites({required FilmSummary film}) async {
    try {
      final response = await http.post(
          Uri.parse("$_baseUrl/movies/delete-favourite"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(
            {
              "movie_id": film.imdbID,
              "user_id": 1,
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
  Future<List<FilmSummary>?> getFavouritedFilms() async {
    await Future.delayed(Duration(milliseconds: 500));
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/movies/get-favourites"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        return jsonResponse.map((filmJson) {
          return FilmSummary.fromJson(filmJson as Map<String, dynamic>);
        }).toList();
      } else {
        throw Exception("failed to fetch favourites from server");
      }
    } catch (e) {
      throw Exception("Failed to load favourites: ${e.toString()}");
    }
  }

  @override
  Future<void> addFilm({required Film film}) async {
    try {
      final response = await http.post(Uri.parse("$_baseUrl/movies/add-movie"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(
            {
              "title": film.title,
              "description": film.plot,
              "release_date": int.parse(film.year),
              "genre": film.genre,
              "rating": double.parse(film.imdbRating)
            },
          ));
      if (response.statusCode != 200) {
        throw Exception("failed to add film");
      }
    } catch (e) {
      throw Exception('Failed to add film to the server: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFilm({required int id}) async {
    try {
      final response = await http.post(
          Uri.parse("$_baseUrl/movies/remove-movie"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(
            {
              "movie_id": id,
            },
          ));

      if (response.statusCode != 200) {
        throw Exception("failed to remove film");
      }
    } catch (e) {
      throw Exception('Failed to remove film from the server: ${e.toString()}');
    }
  }
}
