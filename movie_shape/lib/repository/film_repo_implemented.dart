import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_shape/models/film.dart';
import 'package:movie_shape/models/film_summary.dart';
import 'package:movie_shape/repository/film_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "../models/film_search.dart";

FilmSummary summaryFromJson(Map<String, dynamic> json) {
  const String defaultPosterUrl =
      'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';

  var filmSummary = FilmSummary(
    title: json['Title'] ?? 'Unknown Title',
    year: json['Year'] ?? 'Unknown Year',
    type: json['Type'] ?? 'Unknown Type',
    imdbID: json['imdbID'] ?? 'Unknown imdbID',
    // if response is 'N/A' set to default poster, if null
    poster: Uri.tryParse(json['Poster'] ?? '')?.hasAbsolutePath == true
        ? json['Poster']
        : defaultPosterUrl,
  );

  return filmSummary;
}

FilmsSearch searchFromJson(Map<String, dynamic> json) {
  return FilmsSearch(
    // convert JSON list into FilmSummary class
    films: (json['Search'] as List<dynamic>?)
            ?.map((item) => summaryFromJson(item as Map<String, dynamic>))
            .toList() ??
        [],
    totalResults: json['totalResults'] ?? '0',
    response: json['Response'] ?? 'False',
  );
}

// Repository for handling API requests with OMDb API
class FilmRepoImplemented implements FilmRepo {
  static const String _apiKey = "f7594dee";
  static const String _baseUrl = "http://omdbapi.com/";

  @override
  Future<Film> getFilmById(
      {required String id, bool longDescription = false}) async {
    try {
      String query = "https://www.omdbapi.com/?apikey=810d5ee8&i=$id";
      if (longDescription) {
        query = "$query&plot=full";
      }

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
  Future<List<FilmSummary>> searchFilmsByTitle(
      {required String searchQuery}) async {
    try {
      final response = await http.get(
          Uri.parse("$_baseUrl?apikey=$_apiKey&type=movie&s=$searchQuery"));

      if (response.statusCode == 200) {
        FilmsSearch searchResponse = searchFromJson(jsonDecode(response.body));
        return searchResponse.films;
      } else {
        throw Exception("Fail");
      }
    } catch (e) {
      throw Exception("failed to load film list: ${e.toString()}");
    }
  }

  @override
  Future<List<FilmSummary>?> getWatchlistFilms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final filmJsonList = prefs.getStringList('watchlist') ?? [];

      if (filmJsonList.isEmpty) {
        return [];
      }

      return filmJsonList.map((filmJson) {
        final filmMap = jsonDecode(filmJson) as Map<String, dynamic>;
        return FilmSummary.fromJson(filmMap);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load watchlist: ${e.toString()}');
    }
  }

  @override
  Future<void> addFilmToWatchlist({required FilmSummary film}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final filmJsonList = prefs.getStringList('watchlist') ?? [];

      // Check if film already exists in watchlist
      final exists = filmJsonList.any((filmJson) {
        final filmMap = jsonDecode(filmJson) as Map<String, dynamic>;
        final existingFilm = FilmSummary.fromJson(filmMap);
        return existingFilm.imdbID == film.imdbID;
      });

      if (!exists) {
        // Convert film to JSON string and add to list
        final filmJson = jsonEncode(film.toJson());
        filmJsonList.add(filmJson);
        await prefs.setStringList('watchlist', filmJsonList);
      }
    } catch (e) {
      throw Exception('Failed to add film to watchlist: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFilmFromWatchlist({required FilmSummary film}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final filmJsonList = prefs.getStringList('watchlist') ?? [];

      // Find and remove the film with matching imdbID
      filmJsonList.removeWhere((filmJson) {
        final filmMap = jsonDecode(filmJson) as Map<String, dynamic>;
        final existingFilm = FilmSummary.fromJson(filmMap);
        return existingFilm.imdbID == film.imdbID;
      });

      await prefs.setStringList('watchlist', filmJsonList);
    } catch (e) {
      throw Exception('Failed to remove film from watchlist: ${e.toString()}');
    }
  }

  @override
  Future<List<FilmSummary>?> getFavouritedFilms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // If favourites doesn't exist, initialise []
      final filmJsonList = prefs.getStringList('favourites') ?? [];

      if (filmJsonList.isEmpty) {
        return [];
      }

      // Iterate and perform a transformation
      return filmJsonList.map((filmJson) {
        // Convert Json list to FilmSummary object
        final filmMap = jsonDecode(filmJson) as Map<String, dynamic>;
        return FilmSummary.fromJson(filmMap);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load favourites: ${e.toString()}');
    }
  }

  @override
  Future<void> addFilmToFavourites({required FilmSummary film}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final filmJsonList = prefs.getStringList('favourites') ?? [];

      // Check if film already exists in watchlist
      final exists = filmJsonList.any((filmJson) {
        final filmMap = jsonDecode(filmJson) as Map<String, dynamic>;
        final existingFilm = FilmSummary.fromJson(filmMap);
        return existingFilm.imdbID == film.imdbID;
      });

      if (!exists) {
        // Convert FilmSummary to JSON string and add to list
        final filmJson = jsonEncode(film.toJson());
        filmJsonList.add(filmJson);
        await prefs.setStringList('favourites', filmJsonList);
      }
    } catch (e) {
      throw Exception('Failed to add film to favourites: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFilmFromFavourites({required FilmSummary film}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final filmJsonList = prefs.getStringList('favourites') ?? [];

      // Find and remove the film with matching imdbID
      filmJsonList.removeWhere((filmJson) {
        final filmMap = jsonDecode(filmJson) as Map<String, dynamic>;
        final existingFilm = FilmSummary.fromJson(filmMap);
        return existingFilm.imdbID == film.imdbID;
      });

      await prefs.setStringList('favourites', filmJsonList);
    } catch (e) {
      throw Exception('Failed to remove film from favourites: ${e.toString()}');
    }
  }

  @override
  Future<void> addFilm({required Film film}) {
    // TODO: implement addMovie
    throw UnimplementedError();
  }

  @override
  Future<void> removeFilm({required int id}) {
    // TODO: implement removeMovie
    throw UnimplementedError();
  }
}
